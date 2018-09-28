#requires -version 5.0

#Pester tests for the PSJsonCredential Module

$modroot = Split-Path (Split-path $MyInvocation.MyCommand.Path)

Write-host "Importing moduling from $modroot" -ForegroundColor Cyan

Import-Module $modRoot -force

InModuleScope PSJsonCredential {
    
    Describe Export {
    
        BeforeAll {
            $plainText = "myPassword"
            $user = "company\administrator"
            $secure = ConvertTo-SecureString -String $plainText -AsPlainText -Force
            $testCredential = New-object -TypeName PSCredential $user, $secure
            $json = Join-Path -Path TESTDRIVE:\ -ChildPath admin.json
        }
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

        It "Should create a json file called admin.json" {
            Split-path -path $script:out.fullname -Leaf | Should be admin.json
        }       

        It "Should not overwrite an existing file if using -NoClobber" {
            $testCredential | Export-PSCredentialToJson -Path $json -NoClobber -OutVariable o -warningaction silentlycontinue
            $o | Should Be $Null
        }

    } #export

    Describe Get {
        BeforeAll {
            $plainText = "myPassword"
            $user = "company\administrator"
            $secure = ConvertTo-SecureString -String $plainText -AsPlainText -Force
            $testCredential = New-object -TypeName PSCredential $user, $secure
            $json = Join-Path -Path TESTDRIVE:\ -ChildPath admin.json
            $testCredential | Export-PSCredentialToJson -path $json
        }

        It "Should run without error" {
        
            {$script:get = Get-PSCredentialFromJson -Path $json -ErrorAction Stop} | Should Not Throw
        }

        It "Should have a user property of $user" {
            $script:get.userName | Should be $user
        }
    
        It "Should have a [string] password" {
            $script:get.password.getType().name | Should beofType "string"
        }
    
        It "Should have an ExportDate property" {
            $d = $script:get.exportDate -as [DateTime]
            $d.GetType().Name | Should be "DateTime"
        }
    
        It "Should have an ExportUser property of $env:username" {
            $script:get.exportUser | Should match $env:username
        }
    
        It "Should have an ExportComputer property of $($env:computername)" {
            $script:get.exportComputer | Should Be $Env:computername
        }

        It "Should have a path property of admin.json" {
            $script:get.path | Should match "admin.json$"
        }
    }

    Describe Import {
        BeforeAll {
            $plainText = "myPassword"
            $user = "company\administrator"
            $secure = ConvertTo-SecureString -String $plainText -AsPlainText -Force
            $testCredential = New-object -TypeName PSCredential $user, $secure
            $json = Join-Path -Path TESTDRIVE:\ -ChildPath admin.json
            $testCredential | Export-PSCredentialToJson -path $json 
        }
        It "Should run without error" {
            {$script:in = Import-PSCredentialFromJson -Path $json -ErrorAction Stop -WarningAction SilentlyContinue} | Should Not Throw
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
} #modulescope

