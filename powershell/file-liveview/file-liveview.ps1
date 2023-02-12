param($targetPath)

if ([string]::IsNullorEmpty($targetPath)) {
    Write-Host '[Example]'
    Write-Host  $myInvocation.MyCommand.name '<TargetFile>'
    return
}

$pre = $null
$now = $null
$raw = $null
while ($true) {
    if (!(Test-Path $targetPath -PathType Leaf)) {
        $raw = "$targetPath not exits."
        $now = [DateTime]"2000/01/01"
    }
    else {
        $now = (Get-ItemProperty $targetPath).LastWriteTime
        $raw = Get-Content -Path $targetPath -Raw
    }
    if (!($pre -eq $now)) {
        cls
        Write-Host -NoNewline "LastUpdateTimeStamp = $now `n----------------------------------`n$raw" 
        $pre = $now
    }
    Start-Sleep -Seconds 1 
}