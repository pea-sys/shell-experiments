$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "Restart-InactiveComputer" {
    Mock Restart-Computer { "Restarting!" }
    Context "Computer should restart" {
        It "Restarts the computer" {
            Mock Get-Process {} -ParameterFilter { $Name -eq "Explorer" }
            Restart-InactiveComputer | Out-Null
            Assert-MockCalled Restart-Computer -Exactly 1 -parameterFilter { $Force }
        }
    }

    Context "Computer should not restart" {
        It "Does not restart the computer if user is logged on" {
            Mock Get-Process { $true } -ParameterFilter { $Name -eq "Explorer" }
            Restart-InactiveComputer | Out-Null
            Assert-MockCalled Restart-Computer -Exactly 0 -parameterFilter { $Force }
        }
    }
}