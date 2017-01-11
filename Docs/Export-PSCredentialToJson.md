---
external help file: PSJsonCredential-help.xml
online link:
schema: 2.0.0
---

# Export-PSCredentialToJson

## SYNOPSIS
Export a PSCredential to a JSON file

## SYNTAX

```
Export-PSCredentialToJson [-Path] <String> -Credential <PSCredential> [-NoClobber] [-Passthru] [-WhatIf] [-Confirm]
```

## DESCRIPTION
This command will take a PSCredential object and export it to a JSON file. The password will be converted from a secure string using native Windows crypto APIs. The converted password can only be re-converted on the original computer. The export process will also capture metadata information including the credential of the user who ran the export and the computername.

The user name will still be in plain text so you should take the necessary steps to safeguard this file. 

NOTE: Storing any sort of credential to disk is a potential security risk and may not be approved in every organization. Use with caution and at your own risk.

## EXAMPLES

### Example 1
```
PS C:\> Export-PSCredentialToJson -path c:\scripts\admin.json -credential "company\administrator"
```

Create a json file in the Scripts folder for the company\administrator credential. You will be prompted for the password.

### Example 2
```
PS C:\> $cred | Export-PSCredentialToJson -path c:\scripts\mycred.json
```

Pipe a previously created PSCredential to the export command.

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
A PSCredential object

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
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

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

## INPUTS
### System.Management.Automation.PSCredential


## OUTPUTS
### System.Object

## NOTES

v1.1.0

Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/


## RELATED LINKS
[http://bit.ly/Export-PSCredentialJson]()

[Get-Credential]()

[ConvertFrom-SecureString]()

[Import-PSCredentialFromJson](Import-PSCredentialFromJson.md)

[Get-PSCredentialFromJson](Get-PSCredentialFromJson.md)

[https://msdn.microsoft.com/en-us/library/system.management.automation.pscredential(v=vs.85).aspx]()
