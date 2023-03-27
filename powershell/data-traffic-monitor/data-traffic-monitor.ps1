#Requires -PSEdition Core
function Write-DataTraffic {
    param (
        $adapterName
    )
    $logFile = "$PSScriptRoot\" + $adapterName + '_history.log'
    $stats = Get-NetAdapterStatistics -Name $adapterName
    $log = '|' + (Get-Date -Format "yyyy/MM/dd HH:mm") + '|' + $stats.ReceivedBytes + 'bytes|' + $stats.SentBytes + 'bytes|' + ($stats.ReceivedBytes + $stats.SentBytes) + 'bytes|'
    $log | Out-File $logFile -Append
}

Write-DataTraffic($args[0])

