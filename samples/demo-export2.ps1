
$credential = Get-Credential company\administrator
$key = ConvertTo-SecureString -String "P@ssw0rdP@ssw0rd" -AsPlainText -Force

$credential | Export-PSCredentialToJson -NoMetaData -EncryptUserName -Key $key -Path .\samplecred2.json

Get-PSCredentialFromJson .\samplecred2.json