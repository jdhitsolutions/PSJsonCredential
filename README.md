# PSJsonCredential

[![PSGallery Version](https://img.shields.io/powershellgallery/v/PSJsonCredential.png?style=for-the-badge&logo=powershell&label=PowerShell%20Gallery)](https://www.powershellgallery.com/packages/PSJsonCredential/) [![PSGallery Downloads](https://img.shields.io/powershellgallery/dt/PSJsonCredential.png?style=for-the-badge&label=Downloads)](https://www.powershellgallery.com/packages/PSJsonCredential/)

This PowerShell module contains a set of functions for storing a PSCredential object in a JSON file. Previous versions of this module relied on the CryptoAPI which limited it to Windows platforms only. This version uses a user-defined key to convert the password to a secure string that can be stored in the JSON file. The module should now work in Windows PowerShell and PowerShell 7.

## Release

The most current version is available from the PowerShell Gallery.

```powershell
PS C:\> Install-Module PSJsonCredential
```

## Why?

You can achieve similar results using the [Export-CliXML](http://go.microsoft.com/fwlink/?LinkId=821767) and [Import-Clixml](http://go.microsoft.com/fwlink/?LinkId=821813) cmdlets. But those techniques rely on the CryptoAPI and are limited to Windows platforms. The files can also only be used on the computer where they were created only by the original user. Earlier versions of this module relied on these techniques.

The current version of the module relies on a user-defined key which you can think of as a password or passphrase. __You need to know the key to export and import the credential__. This has the added benefit of making the JSON file portable between computers.

## Usage

### Export

You can pipe any PSCredential object to [Export-PSCredentialToJson](docs/Export-PSCredentialToJson.md).

```powershell
PS C:\> $cred = Get-Credential Company\Administrator
PS C:\> $skey = Read-Host "Enter a 16 character key" -asSecureString
Enter a 16 character key: ****************
PS C:\> $skey.Length
16
PS C:\> $cred | Export-PSCredentialToJson -Path c:\work\admin.json -key $skey
```

The export process will also capture metadata information about who converted the credential.

```powershell
PS C:\> Get-Content C:\work\admin.json
{
  "UserName": "company\\administrator",
  "Password": {
    "value": "76492d1116743f0423413b16050a5345MgB8AEUARwBrAHAASABwAE8AdgBOAEgAWgA2AHkAWAA4AEYANgA4AEkAVQBKAEEAPQA9AHwAZQAzADAAMAA1ADEAOQAzADEANAA0AGIAYQA3AGEAOQBmAGMAZQAwADQANAAzADMAOAAxADEAMgA5ADAAMABkADkANwAzADAAZgAzADcAYgA0AGYAZQBiAGUANQBhADAAMgBmADEAZABkAGUAZQBjADMAZAA2AGYAYQA5AGUAMQA="
    },
  "Metadata": {
    "ExportDate": "7/19/2023 7:54:02 PM",
    "ExportUser": "DESK10\\Jeff",
    "ExportComputer": "DESK10"
    "Comment": ""
  }
}
```

Beginning with v2.2.0, you also have the option to encrypt the user name in the JSON file.

```powershell
PS C:\> $credential | Export-PSCredentialToJson -NoMetaData -EncryptUserName -Key $key -Path D:\Save\export.json
PS C:\> Get-Content D:\Save\export.json
{
    "Username":  "76492d1116743f0423413b16050a5345MgB8AHUASwBjADQAagArAFgAUABaAGoARwB0AGcASgBJAFcANgBqADkAcABWAGcAPQA9AHwAOQBlADkAZQA5AGMAZAA1ADgAOQBlAGIAYgBlADgAYQA5ADYAMwBhADIANQAwADQAOQA2AGMAMgBjADEAZQA1ADAAZAAzAGMAMABjADAAMgAwAGQAZgA3ADQANwBlADAANwA4ADcAOQBkADMAOAA0AGMANQA2ADEAYQBiADYAZABhAGUAYwAyAGQAYQA2ADUAMABhADkAMQAzADkAMgA0AGQAMwBmADEANABlADUAYQA3ADYAZgA4AGIAOQAzADUA",
    "Password":  "76492d1116743f0423413b16050a5345MgB8ADQAcABVAEMAaQA5AHQARgBTAGMAYQBZAG0ATQBwAHAAUwByADIASABXAEEAPQA9AHwAZQAyADUAOAAxADgAYwAyADEAOQBlAGMANgAyAGYAYgAyADYAMwA3AGEAYwAxADYANgA0AGQAZABkADMAMQBmADYANQBiADgANAAwADEAZgA1AGMAOQBhAGYAMQBiADEAYwAyADMAYwAwAGEAOQBhAGMAZABjADIAOAA2ADMAMQA="
}
```

### Viewing the Export

You can "get" the credential from the JSON file but without converting the password with [Get-PSCredentialFromJson](docs/Get-PSCredentialFromJson.md)

```powershell
PS C:\> Get-PSCredentialFromJson -Path C:\work\admin.json


   Path: C:\work\admin.json


Username       : company\administrator
Password       : 76492d1116743f0423413b16050a5345MgB8AEwAcAB3AGoARABOAGk
                 AbABKAFgARAB6AEEAUQBPADYAVwBPAHgAZgB1AEEAPQA9AHwAYwA0AG
                 MAZgAyAGMAYQBjAGEAMQBlAGMAMQBhADgAOQAwADAANgBkADgAYgA3A
                 DMANgA4AGUAZABiADUAOAA0AGYANgA3ADYAYgBlAGYAOAA0AGUAOQBl
                 ADIAOAAwADcANQBjADgAYwA1AGUAMQBhAGMANgBhADAAYgBkADIAYgA=
ExportDate     : 8/2/2023 12:53:32 PM
ExportUser     : COMPANY\Jeff
ExportComputer : DESK11
Comment        :
```

There is also a named list view called `nometa`.

```powershell
PS C:\> Get-PSCredentialFromJson -Path C:\work\admin.json | Format-List -view nometa


   Path: C:\work\admin.json


Username       : company\administrator
Password       : 76492d1116743f0423413b16050a5345MgB8AEwAcAB3AGoARABOAGk
                 AbABKAFgARAB6AEEAUQBPADYAVwBPAHgAZgB1AEEAPQA9AHwAYwA0AG
                 MAZgAyAGMAYQBjAGEAMQBlAGMAMQBhADgAOQAwADAANgBkADgAYgA3A
                 DMANgA4AGUAZABiADUAOAA0AGYANgA3ADYAYgBlAGYAOAA0AGUAOQBl
                 ADIAOAAwADcANQBjADgAYwA1AGUAMQBhAGMANgBhADAAYgBkADIAYgA=
Comment        :
```

### Importing

And when you are ready, you can import the credential using [Import-PSCredentialFromJson](docs/Import-PSCredentialFromJson.md)

```powershell
PS C:\> $in = Import-PSCredentialFromJson -Path C:\scripts\admin.json -key $skey --Verbose
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
P@ssw0rd
```

## Samples

You can find demonstration scripts using the module commands in the [Samples](samples) folder.

## Is It Safe

The commands use the secure string convert cmdlets. The password is encoded with a user-defined key which can be a password or phrase of length 16, 24, or 32. Any password stored on disk is a potential security risk.

Because the JSON file is a plain text file, the user and computer name will be visible. You should still take precautions to secure and protect the JSON file.

### Important

Storing any credential to disk poses a potential security risk. It is up to you to decide if you wish to use the commands in this module. Some organizations may have security or usage policies in place that forbid the behavior.

> *__Use with caution and at your own risk.__*
