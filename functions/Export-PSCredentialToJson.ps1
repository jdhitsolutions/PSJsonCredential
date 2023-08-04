Function Export-PSCredentialToJson {
    [CmdletBinding(SupportsShouldProcess,DefaultParameterSetName = "comment")]
    [OutputType('None', 'System.IO.FileInfo')]

    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            HelpMessage = 'Enter the name and path of the json file to create.'
        )]
        [ValidateNotNullOrEmpty()]
        [ValidatePattern('\.json$')]
        [String]$Path,

        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [PSCredential]$Credential,

        [Parameter(Mandatory, HelpMessage = 'Enter a key password or passphrase of length 16, 24 or 32.')]
        [ValidateScript({ $_.length -eq 16 -OR $_.length -eq 24 -OR $_.length -eq 32 })]
        [System.Security.SecureString]$Key,

        [Parameter(HelpMessage = 'Encrypt the user name as a secure string')]
        [Switch]$EncryptUserName,

        [Parameter(HelpMessage = "Don't overwrite an existing file.")]
        [Switch]$NoClobber,

        [Parameter(ParameterSetName = 'noMetadata', HelpMessage = 'Do not include metadata in the json file')]
        [Switch]$NoMetadata,

        [Parameter(ParameterSetName = 'metadata')]
        [string]$Comment,

        [Switch]$PassThru
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.MyCommand)"
        Write-Verbose "[BEGIN  ] Exporting credential to $Path"
    } #begin

    Process {
        Write-Verbose "[PROCESS] Processing credential for $($credential.UserName)"

        if ($NoClobber -AND (Test-Path -Path $path)) {
            Write-Warning "$path already exists and NoClobber specified."
            #bail out out
            Return
        }

        Write-Verbose "[PROCESS] Preparing key with a length of $($key.length)"
        $cKey = _convertSecureString $key
        $secret = _getBytes $cKey

        Try {
            #create a custom object from the credential and convert it to JSON
            if ($EncryptUserName) {
                $content = $Credential | Select-Object -Property @{Name = 'Username';
                    Expression = {
                        #convert to a secure string then convert from using the secret
                        ConvertTo-SecureString -String $_.UserName -AsPlainText -Force |
                        ConvertFrom-SecureString -Key $secret
                    }
                },
                @{Name = 'Password'; Expression = { $_.password | ConvertFrom-SecureString -Key $secret } }
            }
            else {
                $content = $Credential | Select-Object -Property Username, @{Name = 'Password';
                    Expression = { $_.password | ConvertFrom-SecureString -Key $secret }
                }
            }
            if ( -not $NoMetadata) {
                $meta = [PSCustomObject]@{
                    ExportDate     = (Get-Date).ToString()
                    ExportUser     = "$([system.environment]::UserDomainName)\$([system.environment]::username)"
                    ExportComputer = [System.Environment]::MachineName
                    Comment        = $Comment
                }
                $content | Add-Member -MemberType NoteProperty -Name Metadata -Value $meta
            } #if -not metadata
            else {
                Write-Verbose '[PROCESS] Excluding metadata'
            }

            $json = $content | ConvertTo-Json -ErrorAction Stop

            if ($PSCmdlet.ShouldProcess($path, 'Create json Credential File')) {
                $json | Set-Content -Path $Path -ErrorAction Stop

                if ($PassThru ) {
                    Get-Item -Path $path
                }
            } #WhatIf
        } #Try
        Catch {
            Throw $_
        } #Catch
    } #process

    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.MyCommand)"
    } #end

}
