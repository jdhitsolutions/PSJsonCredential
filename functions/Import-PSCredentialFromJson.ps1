Function Import-PSCredentialFromJson {
    [CmdletBinding()]
    [OutputType('PSCredential')]

    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            HelpMessage = 'Enter the name of a json file',
            ValueFromPipeline
        )]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
            if (Test-Path $_) {
                $True
            }
            else {
                Throw "Cannot validate path $_"
            }
        })]
        [String]$Path,
        [Parameter(Mandatory, HelpMessage = 'Enter a key password or passphrase of length 16, 24 or 32.')]
        [ValidateScript({ $_.length -eq 16 -OR $_.length -eq 24 -OR $_.length -eq 32 })]
        [System.Security.SecureString]$Key
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.MyCommand)"
    } #begin

    Process {
        Write-Verbose "[PROCESS] Processing credential from $Path"
        #read in the json file and convert it to an object
        $in = Get-Content -Path $path | ConvertFrom-Json

        Write-Verbose "[PROCESS] Preparing key with a length of $($key.length)"
        $cKey = _convertSecureString $key
        $secret = _getBytes $cKey

        #4 Aug 2023 Username might be encrypted so test length and decrypt if necessary
        if ($In.UserName.length -ge 50) {
            Write-Verbose '[PROCESS] Detected protected username'
            $user = _convertSecureString (ConvertTo-SecureString $in.username -key $secret)
        }
        else {
            $User = $in.Username
        }
        Try {
            Write-Verbose '[PROCESS] Converting password to System.Security.SecureString'
            #depending on the version of Convert-fromJson the converted password might
            #be a nested object or a string. This code hopefully handles both situations.
            if ($in.password.value) {
                $Value = $in.Password.Value
            }
            else {
                $Value = $in.Password
            }
            $secure = ConvertTo-SecureString -String $Value -Key $secret -ErrorAction Stop
        }
        Catch {
            Write-Warning $_.exception.message
        }

        if ($secure) {
            Write-Verbose "[PROCESS] Creating credential for $User"
            New-Object -TypeName PSCredential $user, $secure
        }
    } #process

    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.MyCommand)"
    } #end

}
