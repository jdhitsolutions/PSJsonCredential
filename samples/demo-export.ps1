
$credential = Get-Credential company\april
$key = ConvertTo-SecureString -String "P@ssw0rdP@ssw0rd" -AsPlainText -Force

$credential | Export-PSCredentialToJson -Key $key -Path .\samplecred.json -Comment "pizza pizza" -verbose

Get-PSCredentialFromJson .\samplecred.json