$target = "イーサネット"
#netshコマンド実行のために管理者権限を要求
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrators")) {
    Start-Process pwsh.exe "-File `"$PSCommandPath`"" -Verb RunAs; exit
}

Function Get-StatusFromValue {
    Param($sv)
    switch ($sv) {
        0 { " Disconnected" }
        1 { " Connecting" }
        2 { " Connected" }
        3 { " Disconnecting" }
        4 { " Hardware not present" }
        5 { " Hardware disabled" }
        6 { " Hardware malfunction" }
        7 { " Media disconnected" }
        8 { " Authenticating" }
        9 { " Authentication succeeded" }
        10 { " Authentication failed" }
        11 { " Invalid Address" }
        12 { " Credentials Required" }
        Default { "Not connected" }
    }
}
while ($true) {
    $now = Get-Date
    Write-Host $now 
    $adapter = Get-NetAdapter | Where-Object { $_.Name -eq $target }
    if ($adapter.State -eq 2) {
        netsh interface set interface $target disable
    }
    elseif ($adapter.State -eq 3) {
        netsh interface set interface $target enable
    }
    $state = Get-StatusFromValue($adapter.State)
    Write-Host $state
    Start-Sleep -Seconds  20
}