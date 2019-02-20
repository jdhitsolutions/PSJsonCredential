---
external help file: PSJsonCredential-help.xml
Module Name: PSJsonCredential
online link: https://github.com/jdhitsolutions/PSJsonCredential/blob/master/Docs/Export-PSCredentialToJson.md
schema: 2.0.0
---

# Export-PSCredentialToJson

## SYNOPSIS

Export a PSCredential to a JSON file

## SYNTAX

```yaml
Export-PSCredentialToJson [-Path] <String> -Credential <PSCredential> -Key <String> [-NoClobber] [-NoMetadata] [-Passthru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

This command will take a PSCredential object and export it to a JSON file. The password will be converted from a secure string using a user specified key. The converted password can only be re-converted using the key. The export process will also capture metadata information including the credential of the user who ran the export and the computername, although this is an optional process.

The user and computer name will still be in plain text so you should take the necessary steps to safeguard this file. Running this command is merely the first step.

NOTE: Storing any sort of credential to disk is a potential security risk and may not be approved in every organization. Use with caution and at your own risk.

## EXAMPLES

### Example 1

```powershell
PS C:\> Export-PSCredentialToJson -path c:\scripts\admin.json -credential "company\administrator" -key "I am the walrus!"
PS C:\> Get-Content c:\scripts\admin.json

{
  "UserName": "company\\administrator",
  "Password": {
    "value": "76492d1116743f0423413b16050a5345MgB8AEUARwBrAHAASABwAE8AdgBOAEgAWgA2AHkAWAA4AEYANgA4AEkAVQBKAEEAPQA9AHwAZQAzADAAMAA1ADEAOQAzADEANAA0AGIAYQA3AGEAOQBmAGMAZQAwADQANAAzADMAOAAxADEAMgA5ADAAMABkADkANwAzADAAZgAzADcAYgA0AGYAZQBiAGUANQBhADAAMgBmADEAZABkAGUAZQBjADMAZAA2AGYAYQA5AGUAMQA="},
  "Metadata": {
    "ExportDate": "2/19/2019 7:54:02 PM",
    "ExportUser": "DESK10\\Jeff",
    "ExportComputer": "DESK10"
  }
}
```

Create a json file in the Scripts folder for the company\administrator credential. You will be prompted for the password. The password will be converted to a secure string using the specified key.

### Example 2

```powershell
PS C:\> $cred | Export-PSCredentialToJson -path c:\scripts\admin.json -key "Apples and Oranges are the same." -nometadata
```

Pipe a previously created PSCredential to the export command without any metadata such as the export date or user.

## PARAMETERS

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential

A PSCredential object.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -NoClobber

Do not overwrite an existing file.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Passthru

Display the json file object.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

Enter the name and path for the JSON file.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Key

Enter a key password or passphrase of length 16, 24 or 32.

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

### -NoMetadata

Do not include metadata in the json file.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSCredential

## OUTPUTS

### None

### System.IO.FileInfo

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[http://bit.ly/Export-PSCredentialJson]()

[Get-Credential]()

[ConvertFrom-SecureString]()

[Import-PSCredentialFromJson](Import-PSCredentialFromJson.md)

[Get-PSCredentialFromJson](Get-PSCredentialFromJson.md)

[https://msdn.microsoft.com/en-us/library/system.management.automation.pscredential(v=vs.85).aspx]()
