Function Get-PSCredentialFromJson {
    [CmdletBinding()]
    [OutputType('psJSONCredential')]

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
        [String]$Path
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.MyCommand)"
    } #begin

    Process {
        Write-Verbose "[PROCESS] Processing credential from $Path"

        #read in the json file and convert it to an object
        $in = Get-Content -Path $path | ConvertFrom-Json
        [PSCustomObject]@{
            PSTypeName     = 'psJSONCredential'
            Username       = $in.UserName
            Password       = $in.Password
            ExportDate     = $in.metadata.ExportDate
            ExportUser     = $in.metadata.ExportUser
            ExportComputer = $in.metadata.ExportComputer
            Comment        = $in.metadata.Comment
            Path           = Convert-Path -Path $Path
        }
    } #process

    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.MyCommand)"
    } #end

}
