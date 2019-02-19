# PSJsonCredential

This PowerShell module contains a set of functions for storing a PSCredential object in a JSON file. This will only work on Windows-based systems.

## Release

The most current version is available on the PowerShell Gallery.

```powershell
PS C:\> Install-Module PSJsonCredential
```

## Why?

You can achieve similar results using the [Export-CliXML](http://go.microsoft.com/fwlink/?LinkId=821767) and [Import-Clixml](http://go.microsoft.com/fwlink/?LinkId=821813) cmdlets. The resulting XML files are slightly larger in size and the conversion is slightly longer, but only by a few milliseconds. I merely wanted to provide an alternative file format and json is a popular option these days.

## Usage

You can pipe any PSCredential object to `Export-PSCredentialToJson`.

```powershell
PS C:\> $cred = Get-Credential Company\Administrator
PS C:\> $cred | Export-PSCredentialToJson -Path c:\work\admin.json
```

The export process will also capture metadata information about who converted the credential.

```powershell
PS C:\> get-content C:\work\admin.json
{
    "UserName":  "Company\\Administrator",
    "Password":  "01000000d08c9ddf0115d1118c7a00c04fc297eb010000001368e9622137b247acf0b7a1a65648c8000000
000200000000001066000000010000200000003a58b21348a5b9560ef88dd463138c72561a6e1413437335da951cffa033a9d800
0000000e800000000200002000000033e9e6bc17a4a420b2e7bc621ced2ac8f04ef3c11f33219670b6463facc3058b2000000079
59c03f0cb78b8b9c047a80658701231561193ed8624a5d0769b527bd7026ab400000005346e70d38eeffc2031564eea669d9db98
3a65acbb4bbfc27b9715056eeb42b083badca75687b6feb89794c7570cf565758295cb2fae4fdc98d332601c96e270",
    "metadata":  {
                     "ExportDate":  "12/24/2017 10:33:31 AM",
                     "ExportUser":  "Company\\Jeff",
                     "ExportComputer":  "WIN10-ENT-01"
                 }
}
```

You can "get" the credential from the JSON file but without converting the password.

```powershell
PS C:\> Get-PSCredentialFromJson -Path C:\work\admin.json


UserName       : Company\Administrator
Password       : 01000000d08c9ddf0115d1118c7a00c04fc297eb010000001368e9622137b247acf0b7a1a65648c8000000
                    000200000000001066000000010000200000003a58b21348a5b9560ef88dd463138c72561a6e1413437335
                    da951cffa033a9d8000000000e800000000200002000000033e9e6bc17a4a420b2e7bc621ced2ac8f04ef3
                    c11f33219670b6463facc3058b200000007959c03f0cb78b8b9c047a80658701231561193ed8624a5d0769
                    b527bd7026ab400000005346e70d38eeffc2031564eea669d9db983a65acbb4bbfc27b9715056eeb42b083
                    badca75687b6feb89794c7570cf565758295cb2fae4fdc98d332601c96e270
ExportDate     : 12/24/2017 10:33:31 AM
ExportUser     : Company\Jeff
ExportComputer : WIN10-ENT-01
Path           : C:\work\admin.json
```

And when you are ready you can import the credential.

```powershell
PS C:\> $in = Import-PSCredentialFromJson -Path C:\work\admin.json -Verbose
VERBOSE: [BEGIN  ] Starting: Import-PSCredentialFromJson
VERBOSE: [PROCESS] Processing credential from C:\work\admin.json
VERBOSE: [PROCESS] Converting to System.Security.SecureString
VERBOSE: [PROCESS] Creating credential for Company\Administrator
VERBOSE: [END    ] Ending: Import-PSCredentialFromJson

PS C:\> $in

UserName                                  Password
--------                                  --------
Company\Administrator System.Security.SecureString


PS C:\> $in.GetNetworkCredential().password
PSM@g1ck
```

## Is It Safe?

The commands use the secure string convert cmdlets. These cmdlet rely on Windows crypto APIs to properly convert a secure string. The converted string can only be decrypted on the original computer. If the file is copied to another computer, the `ConvertTo-SecureString` command will fail. 

Because the json file is a plain text file, the user and computer name will be visible. You should still take precautions to secure and protect the json file.

### Important!

Storing any credential to disk poses a potential security risk. It is up to you to decide if you wish to use the commands in this module. Some organizations may have security or usage policies in place that forbid the behavior.

#### *Use with caution and at your own risk.*

*Last updated 23 October 2018*
