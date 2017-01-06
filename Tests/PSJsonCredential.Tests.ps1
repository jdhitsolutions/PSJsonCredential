#requires -version 5.0

#Pester tests for the PSJsonCredential Module

$modroot = Split-Path (Split-path $MyInvocation.MyCommand.Path)

Write-host "Importing moduling from $modroot" -ForegroundColor Cyan

Import-Module $modRoot -force

InModuleScope PSJsonCredential {

$plainText = "myPassword"
$user = "company\administrator"
$secure = ConvertTo-SecureString -String $plainText -AsPlainText -Force
$testCredential = New-object -TypeName PSCredential $user,$secure
$json = Join-Path -Path $env:TEMP -ChildPath admin.json

Describe Export {

    It "Should run with out error" {
        { Export-PSCredentialToJson -credential $testCredential -Path $json -ErrorAction Stop} | Should Not Throw
    }

    It "Should run with pipeline input" {
        { $testCredential | Export-PSCredentialToJson -Path $json -ErrorAction Stop} | Should Not Throw
    }
    It "Should fail with a bad path" {
        { $testCredential | Export-PSCredentialToJson -Path Foo:\foo.json} | Should Throw
    }

    It "Should create a file object when using -Passthru" {
        $script:out = $testCredential | Export-PSCredentialtoJson -path $json -passthru
        $script:out.getType().Name | Should Be FileInfo
    }

    It "Should create a json file called $json" {
        $script:out.fullname | Should be $json
    }       

    It "Should not overwrite an existing file if using -NoClobber" {
        $testCredential | Export-PSCredentialToJson -Path $json -NoClobber -OutVariable o
        $o | Should Be $Null
    }

}

Describe Get {
    It "Should run without error" {
        {$script:get = Get-PSCredentialFromJson -Path $json -ErrorAction Stop} | Should Not Throw
    }

    It "Should have a user property of $user" {
        $script:get.userName | Should be $user
    }
    
    It "Should have a [string] password" {
        $script:get.password.getType().name | Should be "string"
    }
    
    It "Should have an ExportDate property" {
        $d = $script:get.exportDate -as [DateTime]
        $d.GetType().Name | Should be "DateTime"
    }
    
    It "Should have an ExportUser property of $user" {
        $script:get.exportUser | Should Be "$($env:computername)\$($env:username)"
    }
    
    It "Should have an ExportComputer property of $($env:computername)" {
        $script:get.exportComputer | Should Be $Env:computername
    }

    It "Should have a path property of $json" {
        $script:get.path | Should Be $json
    }
}

Describe Import {
    It "Should run without error" {
        {$script:in = Import-PSCredentialFromJson -Path $json -ErrorAction Stop} | Should Not Throw
    }
    
    It "Should create a PSCredential object" {
        $Script:in.GetType().Name | Should Be "PSCredential"
    }

    It "Should have a UserName property of $user" {
        $script:in.UserName | Should be $user
    }

    It "Should have a secure string password that decrypts to '$plaintext'" {
        $Script:in.GetNetworkCredential().Password | Should Be $plaintext
    }
}

#remove json file
If (Test-Path -Path $json) {
    Remove-Item -Path $json
}
}

