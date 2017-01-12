#requires -version 5.0.0.0

Function Export-PSCredentialToJson {

[cmdletbinding(SupportsShouldProcess,HelpUri="http://bit.ly/Export-PSCredentialJson")]
Param(
[Parameter(Position = 0, Mandatory, HelpMessage = "Enter the name of a json file")]
[ValidateNotNullorEmpty()]
[string]$Path,
[Parameter(Mandatory,ValueFromPipeline)]
[ValidateNotNullorEmpty()]
[PSCredential]$Credential,
[Switch]$NoClobber,
[switch]$Passthru
)

Begin {
    Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"  
    Write-Verbose "[BEGIN  ] Exporting credential to $Path"
} #begin

Process {
    Write-Verbose "[PROCESS] Processing credential for $($credential.UserName)"
    #display PSBoundparameters formatted nicely for Verbose output  
    [string]$pb = ($PSBoundParameters | Format-Table -AutoSize | Out-String).TrimEnd()
    Write-Verbose "[PROCESS] PSBoundParameters: `n$($pb.split("`n").Foreach({"$("`t"*2)$_"}) | Out-String) `n" 

    if ($NoClobber -AND (Test-Path -Path $path)) {
        Write-Warning "$path already exists and NoClobber specified."
        #bail out out
        Return
     }
    
    Try {

        #create a custom object from the credential and convert it to JSON    
        $Credential | Select Username,@{Name="Password";
        Expression = { $_.password | ConvertFrom-SecureString }},
        @{Name="metadata";Expression={ [pscustomobject]@{
            ExportDate = (Get-Date).Tostring()
            ExportUser = "$($env:userdomain)\$($env:username)"
            ExportComputer = $env:COMPUTERNAME
        }
        }} | ConvertTo-Json -ErrorAction Stop | 
        Set-Content -Path $Path -ErrorAction Stop
    }
    Catch {
        Throw $_
    }

    if ($Passthru) {
        Get-Item -Path $path
    }
} #process

End {
    Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
} #end

} #close Export-PSCredentialtoJson

Function Import-PSCredentialFromJson {

[cmdletbinding(HelpUri="http://bit.ly/Import-PSCredentialJson")]
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
    #display PSBoundparameters formatted nicely for Verbose output  
    [string]$pb = ($PSBoundParameters | Format-Table -AutoSize | Out-String).TrimEnd()
    Write-Verbose "[PROCESS] PSBoundParameters: `n$($pb.split("`n").Foreach({"$("`t"*2)$_"}) | Out-String) `n" 

    #read in the json file and convert it to an object
    $in = Get-Content -Path $path | ConvertFrom-Json
    
    Try {
        Write-Verbose "[PROCESS] Converting to System.Security.SecureString"
        $secure = ConvertTo-SecureString $in.Password -ErrorAction Stop
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
    #display PSBoundparameters formatted nicely for Verbose output  
    [string]$pb = ($PSBoundParameters | Format-Table -AutoSize | Out-String).TrimEnd()
    Write-Verbose "[PROCESS] PSBoundParameters: `n$($pb.split("`n").Foreach({"$("`t"*2)$_"}) | Out-String) `n" 

    #read in the json file and convert it to an object
    $in = Get-Content -Path $path | ConvertFrom-Json
    $in | Select Username,Password,
    @{Name = "ExportDate";Expression = {$_.metadata.ExportDate}},
    @{Name = "ExportUser";Expression = {$_.metadata.ExportUser}},
    @{Name = "ExportComputer";Expression = {$_.metadata.ExportComputer}},
    @{Name = "Path";Expression = { (Convert-Path -Path $Path) }}
    
    } #process

End {
    Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
} #end

} #close Get-PSCredentialFromJson
