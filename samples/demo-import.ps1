
$key = ConvertTo-SecureString -String "P@ssw0rdP@ssw0rd" -AsPlainText -Force

$import = Import-PSCredentialFromJson -Key $key -Path $PSScriptRoot\samplecred.json -Verbose

$import

$import.GetNetworkCredential().Password