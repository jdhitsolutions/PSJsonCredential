
$key = ConvertTo-SecureString -String "P@ssw0rdP@ssw0rd" -AsPlainText -Force

$import = Import-PSCredentialFromJson -Key $key -Path $PSScriptRoot\samplecred2.json

$import

$import.GetNetworkCredential().Password