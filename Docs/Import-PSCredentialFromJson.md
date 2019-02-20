---
external help file: PSJsonCredential-help.xml
Module Name: PSJsonCredential
online link: https://github.com/jdhitsolutions/PSJsonCredential/blob/master/Docs/Import-PSCredentialFromJson.md
schema: 2.0.0
---

# Import-PSCredentialFromJson

## SYNOPSIS

Import a stored credential from a JSON file.

## SYNTAX

```yaml
Import-PSCredentialFromJson [-Path] <String> -Key <String> [<CommonParameters>]
```

## DESCRIPTION

This command will import a stored PSCredential object from a JSON file. It is assumed the JSON file was created with Export-PSCredentialtoJSON. You will need to specify the same key used to export the credential.

## EXAMPLES

### Example 1

```powershell
PS C:\> Import-PSCredentialFromJson -Path c:\scripts\admin.json -key "I am the walrus!"

UserName                                  Password
--------                                  --------
company\administrator System.Security.SecureString
```

Import the credential from the JSON file. Normally you would save this to a variable so you could re-use it in your PowerShell session.

## PARAMETERS

### -Path

Enter the name and path of a json file.

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

### -Key

Enter a key password or passphrase of length 16, 24 or 32. This will need to be the same key used to export the credential.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### PSCredential

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[http://bit.ly/Import-PSCredentialJson]()

[Get-Credential]()

[ConvertFrom-SecureString]()

[Export-PSCredentialtoJson](Export-PSCredentialToJson.md)

[Get-PSCredentialFromJson](Get-PSCredentialFromJson.md)
