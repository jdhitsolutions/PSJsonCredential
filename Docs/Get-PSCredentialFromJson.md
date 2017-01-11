---
external help file: PSJsonCredential-help.xml
online link:
schema: 2.0.0
---

# Get-PSCredentialFromJson

## SYNOPSIS
Get stored credential information from a JSON file.
## SYNTAX

```
Get-PSCredentialFromJson [-Path] <String>
```

## DESCRIPTION
This command will retrieve credential information from a JSON file created with Export-PSCredentialToJSON. The command will not convert the password but it will include the export metadata.

## EXAMPLES

### Example 1
```
PS C:\> Get-PSCredentialFromJson -path c:\scripts\admin.json

UserName       : company\administrator
Password       : 01000000d08c9ddf0115d1118c7a00c04fc297eb010000001368e9622137b247acf0b7a1a65648c8000000
                 000200000000001066000000010000200000007181f5ee0303464ac7ed8a906c17245830d8862106e94a43
                 b4a335785271c125000000000e800000000200002000000087b3353dd8210916153b1bd1ea0f6062a708b4
                 6f390dfa1e21ddc2db2874a4d920000000b9908f326ae33612af4ddb3e354dd379e813f238a9a29d989a26
                 cf89cb76ff2140000000221703208eab03d90020187b9b49467c071ccb51e531e6b311b31b576b95da4754
                 91e3b0e3a7929883b8cf658adaae2a9317105be5b733ee92981b81af011997
ExportDate     : 12/24/2016 11:01:14 AM
ExportUser     : Desk01\Jeff
ExportComputer : DESK01
Path           : C:\scripts\admin.json
```


## PARAMETERS

### -Path
Enter the name of a json file

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
v1.1.0

Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/


## RELATED LINKS
[http://bit.ly/Get-PScredentialJson]()

[Import-PSCredentialFromJson](Import-PSCredentialFromJson.md)

[Export-PSCredentialtoJson](Export-PSCredentialtoJson.md)

[Get-Credential]()

[ConvertFrom-SecureString]()

