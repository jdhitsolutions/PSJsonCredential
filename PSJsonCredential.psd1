#
# Module manifest for module 'PSJsonCredential'

@{
    RootModule           = 'PSJsonCredential.psm1'
    ModuleVersion        = '2.2.0'
    CompatiblePSEditions = @('Desktop', 'Core')
    GUID                 = 'a582b122-80fd-4fcb-8c01-5520737530c9'
    Author               = 'Jeff Hicks'
    CompanyName          = 'JDH Information Technology Solutions, Inc.'
    Copyright            = '(c) 2017-2023 JDH Information Technology Solutions, Inc. All rights reserved.'
    Description          = 'A set of commands for exporting and importing PSCredentials to a json file.'
    PowerShellVersion    = '5.1'
    FunctionsToExport    = 'Export-PSCredentialToJson', 'Import-PSCredentialFromJson', 'Get-PSCredentialFromJson'
    FormatsToProcess     = '.\formats\psjsoncredential.format.ps1xml'
    CmdletsToExport      = ''
    AliasesToExport      = ''
    PrivateData          = @{
        PSData = @{
            Tags         = @('json', 'pscredential', 'credential', 'securestring')
            LicenseUri   = 'https://github.com/jdhitsolutions/PSJsonCredential/blob/master/License.txt'
            ProjectUri   = 'https://github.com/jdhitsolutions/PSJsonCredential'
            # IconUri = ''
            ReleaseNotes = 'https://github.com/jdhitsolutions/PSJsonCredential/blob/master/README.md'
        } # End of PSData hashtable
    } # End of PrivateData hashtable

}

