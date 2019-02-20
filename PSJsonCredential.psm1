
Function Export-PSCredentialToJson {

[cmdletbinding(SupportsShouldProcess,HelpUri="http://bit.ly/Export-PSCredentialJson")]
[Outputtype("None","System.IO.FileInfo")]

Param(
[Parameter(Position = 0, Mandatory, HelpMessage = "Enter the name and path of the json file to create.")]
[ValidateNotNullorEmpty()]
[ValidatePattern('\.json$')]
[string]$Path,
[Parameter(Mandatory,ValueFromPipeline)]
[ValidateNotNullorEmpty()]
[PSCredential]$Credential,
[Parameter(Mandatory,HelpMessage = "Enter a key password or passphrase of length 16, 24 or 32.")]
[ValidateScript({ $_.length -eq 16 -OR $_.length -eq 24 -OR $_.length -eq 32})]
[string]$Key,
[Switch]$NoClobber,
[Parameter(HelpMessage = "Do not include metadata in the json file")]
[switch]$NoMetadata,
[switch]$Passthru
)

Begin {
    Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"
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
     $secret = [system.text.encoding]::UTF8.GetBytes($key)

    Try {

        #create a custom object from the credential and convert it to JSON
        $content = $Credential | Select-Object Username,@{Name="Password";
        Expression = { $_.password | ConvertFrom-SecureString -key $secret }}
        if ( -not $NoMetadata) {
            $meta =  [pscustomobject]@{
                ExportDate = (Get-Date).Tostring()
                ExportUser = "$([system.environment]::UserDomainName)\$([system.environment]::username)"
                ExportComputer = [System.Environment]::MachineName
            }
            $content | Add-Member -MemberType NoteProperty -Name Metadata -value $meta
        } #if -not metadata
        else {
            Write-Verbose "[PROCESS] Excluding metadata"
        }

        $json = $content | ConvertTo-Json -ErrorAction Stop

        if ($PSCmdlet.ShouldProcess($path,"Create json Credential File")) {
            $json | Set-Content -Path $Path -ErrorAction Stop

                if ($Passthru ) {
                    Get-Item -Path $path
                }
        } #whatif
    }
    Catch {
        Throw $_
    }
} #process

End {
    Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
} #end

} #close Export-PSCredentialtoJson

Function Import-PSCredentialFromJson {

[cmdletbinding(HelpUri="http://bit.ly/Import-PSCredentialJson")]
[OutputType("PSCredential")]

Param(
[Parameter(Position = 0, Mandatory, HelpMessage = "Enter the name of a json file", ValueFromPipeline)]
[ValidateNotNullorEmpty()]
[ValidateScript({
if (Test-Path $_) {
   $True
}
else {
   Throw "Cannot validate path $_"
}
})]
[string]$Path,
[Parameter(Mandatory,HelpMessage = "Enter a key password or passphrase of length 16, 24 or 32.")]
[ValidateScript({$_.length -eq 16 -OR $_.length -eq 24 -OR $_.length -eq 32})]
[string]$Key
)

Begin {
    Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"

} #begin

Process {
    Write-Verbose "[PROCESS] Processing credential from $Path"
    #read in the json file and convert it to an object
    $in = Get-Content -Path $path | ConvertFrom-Json

`   Write-Verbose "[PROCESS] Preparing key with a length of $($key.length)"
    $secret = [system.text.encoding]::UTF8.GetBytes($key)

    Try {
        Write-Verbose "[PROCESS] Converting to System.Security.SecureString"
        #depending on the version of Convert-fromJson the converted password might
        #be a nested object or a string. This code hopefully handles both situations.
        if ($in.password.value) {
             $Value = $in.Password.Value
        }
        else {
            $Value = $in.Password
        }
        $secure = ConvertTo-SecureString -string $Value -key $secret -ErrorAction Stop
    }
    Catch {
        Write-Warning $_.exception.message
    }
    if ($secure) {
        Write-Verbose "[PROCESS] Creating credential for $($in.username)"
        New-Object -TypeName PSCredential $in.username,$secure
    }

    } #process

End {
    Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
} #end

} #close Import-PSCredentialFromJson

Function Get-PSCredentialFromJson {

[cmdletbinding(HelpUri="http://bit.ly/Get-PSCredentialJson")]
[OutputType("PSCustomObject")]

Param(
[Parameter(Position = 0, Mandatory, HelpMessage = "Enter the name of a json file", ValueFromPipeline)]
[ValidateNotNullorEmpty()]
[ValidateScript({
if (Test-Path $_) {
   $True
}
else {
   Throw "Cannot validate path $_"
}
})]
[string]$Path
)

Begin {
    Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"
} #begin

Process {
    Write-Verbose "[PROCESS] Processing credential from $Path"

    #read in the json file and convert it to an object
    $in = Get-Content -Path $path | ConvertFrom-Json
    $in | Select-Object Username,Password,
    @{Name = "ExportDate";Expression = {$_.metadata.ExportDate}},
    @{Name = "ExportUser";Expression = {$_.metadata.ExportUser}},
    @{Name = "ExportComputer";Expression = {$_.metadata.ExportComputer}},
    @{Name = "Path";Expression = { (Convert-Path -Path $Path) }}

    } #process

End {
    Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
} #end

} #close Get-PSCredentialFromJson
