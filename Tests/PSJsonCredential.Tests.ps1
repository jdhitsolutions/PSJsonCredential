#Pester tests for the PSJsonCredential Module

if (Get-Module PSJsonCredential) {
    Remove-Module PSJsonCredential
}
Write-Host "Importing module" -ForegroundColor Cyan

Import-Module "$PSScriptRoot\..\PSJsonCredential.psd1" -Force

#InModuleScope PSJsonCredential {
Describe Export {
    BeforeAll {
        $key = ConvertTo-SecureString -AsPlainText -force -String 'I am the walrus!'
        $plainText = 'myPassword'
        $user = 'company\administrator'
        $secure = ConvertTo-SecureString -String $plainText -AsPlainText -Force
        $TestCredential = [PSCredential]::new($user, $secure)
        $json = Join-Path -Path TESTDRIVE:\ -ChildPath admin.json
    }
    It 'Should run with out error' {
        { Export-PSCredentialToJson -credential $TestCredential -Path $json -key $key -ErrorAction Stop } | Should -Not -Throw
    }

    It 'Should run with pipeline input' {
        { $TestCredential | Export-PSCredentialToJson -Path $json -key $key -ErrorAction Stop } | Should -Not -Throw
    }
    It 'Should fail with a bad path' {
        { $TestCredential | Export-PSCredentialToJson -Path Foo:\foo.json -key $key } | Should -Throw
    }

    It 'Should create a file object when using -Passthru' {
        $script:out = $TestCredential | Export-PSCredentialToJson -path $json -passthru -key $key
        $script:out.getType().Name | Should -Be FileInfo
    }

    It 'Should create a json file called admin.json' {
        Split-Path -Path $script:out.FullName -Leaf | Should -Be admin.json
    }

    It 'Should not overwrite an existing file if using -NoClobber' {
        $TestCredential | Export-PSCredentialToJson -Path $json -key $key -NoClobber -OutVariable o -WarningAction silentlycontinue
        $o | Should -Be $Null
    }

    It 'Should export a credential with no metadata' {
        $TestCredential | Export-PSCredentialToJson -NoMetadata -path $json -key $key
        $in = Get-Content $json | ConvertFrom-Json
        $in.metadata.exportDate | Should -Be $Null
        $in.metadata.exportUser | Should -Be $Null
        $in.metadata.exportComputer | Should -Be $Null
        $in.metadata.Comment | Should -Be $Null
    }

    It 'Should encrypt the username' {
        $TestCredential | Export-PSCredentialToJson -NoMetadata -EncryptUsername -path $json -key $key
        $in = Get-Content $json | ConvertFrom-Json
        $in.UserName.Length | Should -BeGreaterThan 50
    }

} #export

Describe Get {
    BeforeAll {
        $key = ConvertTo-SecureString -AsPlainText -force -String 'I am the walrus!'
        $plainText = 'myPassword'
        $user = 'company\administrator'
        $secure = ConvertTo-SecureString -String $plainText -AsPlainText -Force
        $TestCredential = New-Object -TypeName PSCredential $user, $secure
        $json = Join-Path -Path TESTDRIVE:\ -ChildPath admin.json
        $TestCredential | Export-PSCredentialToJson -path $json -key $key
    }

    It 'Should run without error' {

        { $script:get = Get-PSCredentialFromJson -Path $json -ErrorAction Stop } | Should -Not -Throw
    }

    It "Should have a user property of $user" {
        $script:get.userName | Should -Be $user
    }

    It 'Should have a [string] password' {
        $script:get.password.getType().name | Should -BeOfType 'string'
    }

    It 'Should have an ExportDate property' {
        $d = $script:get.exportDate -as [DateTime]
        $d.GetType().Name | Should -Be 'DateTime'
    }

    It "Should have an ExportUser property of $env:username" {
        $script:get.exportUser | Should -Match $env:username
    }

    It "Should have an ExportComputer property of $($env:computername)" {
        $script:get.exportComputer | Should -Be $Env:computername
    }

    It 'Should have a path property of admin.json' {
        $script:get.path | Should -Match 'admin.json$'
    }
}

Describe Import {
    BeforeAll {
        $key = ConvertTo-SecureString -AsPlainText -force -String 'I am the walrus!'
        $plainText = 'myPassword'
        $user = 'company\administrator'
        $secure = ConvertTo-SecureString -String $plainText -AsPlainText -Force
        $TestCredential = New-Object -TypeName PSCredential $user, $secure
        $json = Join-Path -Path TESTDRIVE:\ -ChildPath admin.json
        $TestCredential | Export-PSCredentialToJson -path $json -key $key
    }
    It 'Should run without error' {
        { $script:in = Import-PSCredentialFromJson -Path $json -key $key -ErrorAction Stop -WarningAction SilentlyContinue } |
        Should -Not -Throw
    }

    It 'Should create a PSCredential object' {
        $Script:in.GetType().Name | Should -Be 'PSCredential'
    }

    It "Should have a UserName property of company\administrator"  {
        $script:in.UserName | Should -Be $User
    }

    It "Should have a secure string password that decrypts to myPassword" {
        $Script:in.GetNetworkCredential().Password | Should -Be $plaintext
    }
}
#} #ModuleScope

