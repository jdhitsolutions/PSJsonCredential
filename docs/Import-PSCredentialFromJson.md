---
external help file: PSJsonCredential-help.xml
Module Name: PSJsonCredential
online link:
schema: 2.0.0
---

# Import-PSCredentialFromJson

## SYNOPSIS

Import a stored credential from a JSON file.

## SYNTAX

```yaml
Import-PSCredentialFromJson [-Path] <String> -Key <SecureString> [<CommonParameters>]
```

## DESCRIPTION

This command will import a stored PSCredential object from a JSON file. It is assumed the JSON file was created with Export-PSCredentialToJSON. You will need to specify the same key used to export the credential.

## EXAMPLES

### Example 1

```powershell
PS C:\> $skey = Read-Host "Enter a 16 character key" -asSecureString
Enter a 16 character key: ****************
PS C:\> $skey.Length
16
PS C:\> Import-PSCredentialFromJson -Path c:\scripts\admin.json -key $skey

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
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### PSCredential

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Export-PSCredentialToJson](Export-PSCredentialToJson.md)

[Get-PSCredentialFromJson](Get-PSCredentialFromJson.md)

[Get-Credential]()

[ConvertFrom-SecureString]()
