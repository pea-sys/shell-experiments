#https://tex2e.github.io/blog/powershell/Register-ObjectEvent
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $env:TEMP 
$watcher.Filter = "*" 
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true

$action = {
    $changeType = $Event.SourceEventArgs.ChangeType
    $path = $Event.SourceEventArgs.FullPath.Replace($env:TEMP, '')
    $color = 'White'
    switch ($changeType) {
        'Created' { $color = 'Green' }
        'Changed' { $color = 'Yellow' }
        'Deleted' { $color = 'Red' }
        'Renamed' { $color = 'Blue' }

    }
    Write-Host "$(Get-Date), $changeType, $path" -ForegroundColor $color
}

Register-ObjectEvent $watcher -EventName 'Created' -Action $action
Register-ObjectEvent $watcher -EventName 'Changed' -Action $action
Register-ObjectEvent $watcher -EventName 'Deleted' -Action $action
Register-ObjectEvent $watcher -EventName 'Renamed' -Action $action

while ($true) { Start-Sleep -Seconds 1 }