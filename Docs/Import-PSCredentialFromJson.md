---
external help file: PSJsonCredential-help.xml
online link:
schema: 2.0.0
---

# Import-PSCredentialFromJson

## SYNOPSIS
Import a stored credential from a JSON file.

## SYNTAX

```
Import-PSCredentialFromJson [-Path] <String>
```

## DESCRIPTION
This command will import a stored PSCredential object from a JSON file. It is assumed the JSON file was created with Export-PSCredentialtoJSON. This command will only work on the same computer where you exported the credential.
## EXAMPLES

### Example 1
```
PS C:\> Import-PSCredentialFromJson -Path c:\scripts\admin.json

UserName                                  Password
--------                                  --------
company\administrator System.Security.SecureString

```

Import the credential from the JSON file. Normally you would save this to a variable so you could re-use it in your PowerShell session.

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
### PSCredential

## NOTES
v1.1.0

Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/


## RELATED LINKS
[http://bit.ly/Import-PSCredentialJson]()

[Get-Credential]()

[ConvertFrom-SecureString]()

[Export-PSCredentialtoJson](Export-PSCredentialToJson.md)

[Get-PSCredentialFromJson](Get-PSCredentialFromJson.md)
