---
external help file: PSJsonCredential-help.xml
online link: https://github.com/jdhitsolutions/PSJsonCredential/blob/master/Docs/Get-PSCredentialFromJson.md
schema: 2.0.0
---

# Get-PSCredentialFromJson

## SYNOPSIS

Get stored credential information from a JSON file.

## SYNTAX

```yaml
Get-PSCredentialFromJson [-Path] <String>
```

## DESCRIPTION

This command will retrieve credential information from a JSON file created with Export-PSCredentialToJSON. The command will not convert the password but it will include the export metadata if provided.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-PSCredentialFromJson -path c:\scripts\admin.json

UserName       : company\administrator
Password       : @{
                 value=76492d1116743f0423413b16050a5345MgB8AEUARwBrAHAASABwAE8AdgBOAEgAWgA2AHkAWAA4AEYANgA4AEkAVQBKAEEAPQA9AHwAZQAzADAAMAA1ADEAOQAzADEANAA0AGIAYQA3AGEAOQBmAGMAZQAwADQANAAzADMAOAAxADEAMgA5ADAAMABkADkANwAzADAAZgAzADcAYgA0AGYAZQBiAGUANQBhADAAMgBmADEAZABkAGUAZQBjADMAZAA2AGYAYQA5AGUAMQA=
                 }
ExportDate     : 2/19/2019 7:54:02 PM
ExportUser     : DESK10\Jeff
ExportComputer : DESK10
Path           : C:\scripts\admin.json
```

## PARAMETERS

### -Path

Enter the name of a json file.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

## INPUTS

### System.String

## OUTPUTS

### System.Object

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[http://bit.ly/Get-PScredentialJson]()

[Import-PSCredentialFromJson](Import-PSCredentialFromJson.md)

[Export-PSCredentialtoJson](Export-PSCredentialtoJson.md)

[Get-Credential]()

[ConvertFrom-SecureString]()
