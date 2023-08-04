---
external help file: PSJsonCredential-help.xml
online link:
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

   Path: C:\scripts\admin.json


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

There is also a named list view called nometa which will suppress the Export properties.

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

### psJSONCredential

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Import-PSCredentialFromJson](Import-PSCredentialFromJson.md)

[Export-PSCredentialToJson](Export-PSCredentialtoJson.md)

[Get-Credential]()

[ConvertFrom-SecureString]()
