# PSJsonCredential

[![PSGallery Version](https://img.shields.io/powershellgallery/v/PSJsonCredential.png?style=for-the-badge&logo=powershell&label=PowerShell%20Gallery)](https://www.powershellgallery.com/packages/PSJsonCredential/) [![PSGallery Downloads](https://img.shields.io/powershellgallery/dt/PSJsonCredential.png?style=for-the-badge&label=Downloads)](https://www.powershellgallery.com/packages/PSJsonCredential/)


This PowerShell module contains a set of functions for storing a PSCredential object in a JSON file. Previous versions of this module relied on the CryptoAPI which limited it to Windows platforms only. This version uses a user defined key to convert the password to a secure string that can be stored in the json file. The module should now work in Windows PowerShell and PowerShell Core.

## Release

The most current version is available on the PowerShell Gallery.

```powershell
PS C:\> Install-Module PSJsonCredential
```

## Why?

You can achieve similar results using the [Export-CliXML](http://go.microsoft.com/fwlink/?LinkId=821767) and [Import-Clixml](http://go.microsoft.com/fwlink/?LinkId=821813) cmdlets. But those techniques rely on the CryptoAPI and are limited to Windows platforms. The files can also only be used on the computer where they were created any by the original user. Earlier versions of this module relied on these techniques.

The current version of the module relies on a user-defined key which you can think of as a password or passphrase. You need to know the key to export and import the credential. This has an added benefit of making the json file portable between computers.

## Usage

You can pipe any PSCredential object to [Export-PSCredentialToJson](Docs/Export-PSCredentialToJson.md).

```powershell
PS C:\> $cred = Get-Credential Company\Administrator
PS C:\> $cred | Export-PSCredentialToJson -Path c:\work\admin.json -key "I am the walrus!"
```

The export process will also capture metadata information about who converted the credential.

```powershell
PS C:\> get-content C:\work\admin.json
{
  "UserName": "company\\administrator",
  "Password": {
    "value": "76492d1116743f0423413b16050a5345MgB8AEUARwBrAHAASABwAE8AdgBOAEgAWgA2AHkAWAA4AEYANgA4AEkAVQBKAEEAPQA9AHwAZQAzADAAMAA1ADEAOQAzADEANAA0AGIAYQA3AGEAOQBmAGMAZQAwADQANAAzADMAOAAxADEAMgA5ADAAMABkADkANwAzADAAZgAzADcAYgA0AGYAZQBiAGUANQBhADAAMgBmADEAZABkAGUAZQBjADMAZAA2AGYAYQA5AGUAMQA="
    },
  "Metadata": {
    "ExportDate": "2/19/2019 7:54:02 PM",
    "ExportUser": "DESK10\\Jeff",
    "ExportComputer": "DESK10"
  }
}
```

You can "get" the credential from the JSON file but without converting the password with [Get-PSCredentialFromJson](Docs/Get-PSCredentialFromJson.md)

```powershell
PS C:\> Get-PSCredentialFromJson -Path C:\work\admin.json


UserName       : company\administrator
Password       : @{value=76492d1116743f0423413b16050a5345MgB8AEUARwBrAHAASABwAE8AdgBOAEgAWgA2AHkAWAA4AEYANgA4AEkAVQBKAE
                 EAPQA9AHwAZQAzADAAMAA1ADEAOQAzADEANAA0AGIAYQA3AGEAOQBmAGMAZQAwADQANAAzADMAOAAxADEAMgA5ADAAMABkADkANwAz
                 ADAAZgAzADcAYgA0AGYAZQBiAGUANQBhADAAMgBmADEAZABkAGUAZQBjADMAZAA2AGYAYQA5AGUAMQA=; Size=276;
                 IsEmail=False}
ExportDate     : 2/19/2019 7:54:02 PM
ExportUser     : DESK10\Jeff
ExportComputer : DESK10
Path           : C:\scripts\admin.json
```

And when you are ready you can import the credential using [Import-PSCredentialFromJson](Docs/Import-PSCredentialFromJson.md)

```powershell
PS C:\> $in = Import-PSCredentialFromJson -Path C:\scripts\admin.json -Verbose -key "I am the walrus!"
VERBOSE: [BEGIN  ] Starting: Import-PSCredentialFromJson
VERBOSE: [PROCESS] Processing credential from C:\scripts\admin.json
VERBOSE: [PROCESS] Preparing key with a length of 16
VERBOSE: [PROCESS] Converting to System.Security.SecureString
VERBOSE: [PROCESS] Creating credential for company\administrator
VERBOSE: [END    ] Ending: Import-PSCredentialFromJson
PS C:\> $in

UserName                                  Password
--------                                  --------
Company\Administrator System.Security.SecureString


PS C:\> $in.GetNetworkCredential().password
P@ssw04d
```

## Is It Safe?

The commands use the secure string convert cmdlets. The password is encoded with a user-defined key which can be a password or phrase of length 16, 24 or 32. Any password stored to disk is a potential security risk.

Because the json file is a plain text file, the user and computer name will be visible. You should still take precautions to secure and protect the json file.

### Important!

Storing any credential to disk poses a potential security risk. It is up to you to decide if you wish to use the commands in this module. Some organizations may have security or usage policies in place that forbid the behavior.

#### *Use with caution and at your own risk.*

*Last updated 20 February 2019*
