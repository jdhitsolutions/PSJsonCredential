---
external help file: PSJsonCredential-help.xml
Module Name: PSJsonCredential
online link:
schema: 2.0.0
---

# Export-PSCredentialToJson

## SYNOPSIS

Export a PSCredential to a JSON file

## SYNTAX

### noMetadata

```yaml
Export-PSCredentialToJson [-Path] <String> -Credential <PSCredential> -Key <SecureString> [-EncryptUserName] [-NoClobber] [-NoMetadata] [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### metadata

```yaml
Export-PSCredentialToJson [-Path] <String> -Credential <PSCredential> -Key <SecureString> [-EncryptUserName] [-NoClobber] [-Comment <String>] [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

This command will take a PSCredential object and export it to a JSON file. The password will be converted from a secure string using a user specified key. The converted password can only be re-converted using the key. The export process will also capture metadata information including the credential of the user who ran the export and the computername, although this is an optional process.

The user and computer name will still be in plain text so you should take the necessary steps to safeguard this file. Running this command is merely the first step.

NOTE: Storing any sort of credential to disk is a potential security risk and may not be approved in every organization. Use with caution and at your own risk.

## EXAMPLES

### Example 1

```powershell
PS C:\> $skey = Read-Host "Enter a 16 character key" -asSecureString
Enter a 16 character key: ****************
PS C:\> $skey.Length
16
PS C:\> Export-PSCredentialToJson -path c:\scripts\admin.json -credential "company\administrator" -key $skey
PS C:\> Get-Content c:\scripts\admin.json

{
  "UserName": "company\\administrator",
  "Password": {
    "value": "76492d1116743f0423413b16050a5345MgB8AEUARwBrAHAASABwAE8AdgBOAEgAWgA2AHkAWAA4AEYANgA4AEkAVQBKAEEAPQA9AHwAZQAzADAAMAA1ADEAOQAzADEANAA0AGIAYQA3AGEAOQBmAGMAZQAwADQANAAzADMAOAAxADEAMgA5ADAAMABkADkANwAzADAAZgAzADcAYgA0AGYAZQBiAGUANQBhADAAMgBmADEAZABkAGUAZQBjADMAZAA2AGYAYQA5AGUAMQA="},
  "Metadata": {
    "ExportDate": "7/19/2023 7:54:02 PM",
    "ExportUser": "DESK11\\Jeff",
    "ExportComputer": "DESK11"
    "Comment": ""
  }
}
```

Create a json file in the Scripts folder for the company\administrator credential. You will be prompted for the password. The password will be converted to a secure string using the specified key.

### Example 2

```powershell
PS C:\> $cred | Export-PSCredentialToJson -Comment "pizza pizza" -Path d:\export\j1987.json -Key $skey
PS C:\> Get-PSCredentialFromJson d:\export\j1987.json


Username       : company\jeff
Password       : 76492d1116743f0423413b16050a5345MgB8AHEAYQArAFgATwBvAGUALwBDAGo
                 AcQBRADIAZwBsAHcATgAxAEEARQBxAHcAPQA9AHwAMgAzAGQAMQAyADYAOAAxADgAYgA1AGQAYgAyAGYAOQA4ADAAMwAxAGUAOABmADgAOABjADkAMgAwADAAYQBjADcANwAxAGYAZgBjADkAZABiADkAOAA1AGQAMQAxADQAYQA3AGMAOAAzADQAYgA2
                 AGYAOAA5ADQAZgBjAGMAMwA=
ExportDate     : 8/4/2023 10:10:53 AM
ExportUser     : DESK11\Jeff,
ExportComputer : DESK11
Comment        : pizza pizza
Path           : D:\export\j1987.json
```

Export the credential with an optional comment.

### Example 3

```powershell
PS C:\> $cred | Export-PSCredentialToJson -EncryptUserName -path c:\scripts\admin.json -key $skey -NoMetadata
```

Pipe a previously created PSCredential to the export command without any metadata such as the export date or user. The username will also be encrypted in the JSON file.

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
Type: SecureString
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
Parameter Sets: noMetadata
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru

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

### -Comment

Include an optional comment in the metadata. This might be a reference to the user name or a hint to the key.

```yaml
Type: String
Parameter Sets: metadata
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EncryptUserName

Encrypt the user name as a secure string.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSCredential

## OUTPUTS

### None

### System.IO.FileInfo

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Import-PSCredentialFromJson](Import-PSCredentialFromJson.md)

[Get-PSCredentialFromJson](Get-PSCredentialFromJson.md)

[Get-Credential]()

[ConvertFrom-SecureString]()
