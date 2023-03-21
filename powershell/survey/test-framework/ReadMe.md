# テストフレームワークを使ってみる

PowerShell スクリプトのテストフレームワークである pester を試してみます。  
https://github.com/pester/Pester  
取り合えず、何でも Official サイトが最強なので、Official に従って動かします。  
https://pester.dev/docs/quick-start

- 環境

```pwsh
PS C:\Users\user> $PSVersionTable

Name                           Value
----                           -----
PSVersion                      7.3.3
PSEdition                      Core
GitCommitId                    7.3.3
OS                             Microsoft Windows 10.0.19045
Platform                       Win32NT
PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0…}
PSRemotingProtocolVersion      2.3
SerializationVersion           1.1.0.1
WSManStackVersion              3.0
```

- 1. Pester のインストール

```pwsh
PS C:\Users\user> Install-Module -Name Pester -Scope CurrentUser -Force
WARNING: Module 'Pester' version '3.4.0' published by 'CN=Microsoft Windows, O=Microsoft Corporation, L=Redmond, S=Washington, C=US' will be superceded by version '5.4.0' published by 'CN=Jakub Jareš, O=Jakub Jareš, L=Praha, C=CZ'. If you do not trust the new publisher, uninstall the module.
```

- 2.Pester モジュールのインポート

```pwsh
PS C:\Users\user> Import-Module Pester -Passthru

ModuleType Version    PreRelease Name                                ExportedCommands
---------- -------    ---------- ----                                ----------------
Script     5.4.0                 Pester                              {Add-ShouldOperator, AfterAll, AfterEach, Assert-MockCalled…}
```

- 3.テスト対象スクリプトを作成します。

```pwsh
function Get-Planet ([string]$Name = '*') {
    $planets = @(
        @{ Name = 'Mercury' }
        @{ Name = 'Venus' }
        @{ Name = 'Earth' }
        @{ Name = 'Mars' }
        @{ Name = 'Jupiter' }
        @{ Name = 'Saturn' }
        @{ Name = 'Uranus' }
        @{ Name = 'Neptune' }
    ) | ForEach-Object { [PSCustomObject] $_ }

    $planets | Where-Object { $_.Name -like $Name }
}

Get-Planet
```

- 4.テストスクリプトを作成します。  
  テストスクリプトはファイル名を「\*.test.ps1」にする必要があります。

```pwsh
BeforeAll {
    . $PSScriptRoot/Get-Planet.ps1
}

Describe 'Get-Planet' {
    It 'Given no parameters, it lists all 8 planets' {
        $allPlanets = Get-Planet
        $allPlanets.Count | Should -Be 8
    }
    It 'Earth is the third planet in our Solar System' {
        $allPlanets = Get-Planet
        $allPlanets[2].Name | Should -Be 'Earth'
    }
    It 'Pluto is not part of our Solar System' {
        $allPlanets = Get-Planet
        $plutos = $allPlanets | Where-Object Name -EQ 'Pluto'
        $plutos.Count | Should -Be 0
    }
    It 'Planets have this order: Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune' {
        $allPlanets = Get-Planet
        $planetsInOrder = $allPlanets.Name -join ', '
        $planetsInOrder | Should -Be 'Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune'
    }
}
```

- 5.テストします。  
  これは全て成功するケース。

```pwsh
PS C:\Users\user\source\repos\test-framework> Invoke-Pester -Output Detailed Get-Planet.Tests.ps1
Pester v5.4.0

Starting discovery in 1 files.
Discovery found 4 tests in 33ms.
Running tests.

Running tests from 'C:\Users\user\source\repos\test-framework\Get-Planet.Tests.ps1'
Describing Get-Planet
  [+] Given no parameters, it lists all 8 planets 18ms (10ms|8ms)
  [+] Earth is the third planet in our Solar System 7ms (5ms|2ms)
  [+] Pluto is not part of our Solar System 8ms (6ms|2ms)
  [+] Planets have this order: Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune 18ms (16ms|1ms)
Tests completed in 253ms
Tests Passed: 4, Failed: 0, Skipped: 0 NotRun: 0
```

- 6.テストを失敗させるため、テスト対象スクリプトから衛星を 1 つ削除します。

```pwsh
function Get-Planet ([string]$Name = '*') {
    $planets = @(
        @{ Name = 'Venus' }
        @{ Name = 'Earth' }
        @{ Name = 'Mars' }
        @{ Name = 'Jupiter' }
        @{ Name = 'Saturn' }
        @{ Name = 'Uranus' }
        @{ Name = 'Neptune' }
    ) | ForEach-Object { [PSCustomObject] $_ }

    $planets | Where-Object { $_.Name -like $Name }
}
```

- 6.テストします。失敗要因が分かりやすく説明されています。

```pwsh
PS C:\Users\user\source\repos\test-framework> Invoke-Pester -Output Detailed Get-Planet.Tests.ps1
Pester v5.4.0

Starting discovery in 1 files.
Discovery found 4 tests in 26ms.
Running tests.

Running tests from 'C:\Users\user\source\repos\test-framework\Get-Planet.Tests.ps1'
Describing Get-Planet
  [-] Given no parameters, it lists all 8 planets 40ms (34ms|6ms)
   Expected 8, but got 7.
   at $allPlanets.Count | Should -Be 8, C:\Users\user\source\repos\test-framework\Get-Planet.Tests.ps1:8
   at <ScriptBlock>, C:\Users\user\source\repos\test-framework\Get-Planet.Tests.ps1:8
  [-] Earth is the third planet in our Solar System 49ms (48ms|1ms)
   Expected strings to be the same, but they were different.
   Expected length: 5
   Actual length:   4
   Strings differ at index 0.
   Expected: 'Earth'
   But was:  'Mars'
              ^
   at $allPlanets[2].Name | Should -Be 'Earth', C:\Users\user\source\repos\test-framework\Get-Planet.Tests.ps1:12
   at <ScriptBlock>, C:\Users\user\source\repos\test-framework\Get-Planet.Tests.ps1:12
  [+] Pluto is not part of our Solar System 3ms (2ms|1ms)
  [-] Planets have this order: Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune 7ms (5ms|1ms)
   Expected strings to be the same, but they were different.
   Expected length: 61
   Actual length:   52
   Strings differ at index 0.
   Expected: 'Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune'
   But was:  'Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune'
              ^
   at $planetsInOrder | Should -Be 'Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune', C:\Users\user\source\repos\test-framework\Get-Planet.Tests.ps1:22
   at <ScriptBlock>, C:\Users\user\source\repos\test-framework\Get-Planet.Tests.ps1:22
Tests completed in 303ms
Tests Passed: 1, Failed: 3, Skipped: 0 NotRun: 0
```

基本的にテスト対象部分は関数にする必要がありそうです。  
Pester を知る前に色々とスクリプトを関数化せずに書き殴ってしまったので、全部書き直したい。  
次の URL に勉強になりそうなリソースが沢山あったので別の機会に追っていきたいと思う。  
https://pester.dev/docs/additional-resources/articles
