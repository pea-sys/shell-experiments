param($targetPath)

if ([string]::IsNullorEmpty($targetPath)) {
    Write-Host '[Example]'
    Write-Host  $myInvocation.MyCommand.name '<TargetFile>'
    return
}
elseif (!(Test-Path $targetPath -PathType Leaf)) {
    Write-Host  'TargetFile not exits.'
    return
}

$pre = $null
while ($true) {
    if (!($pre -eq (Get-ItemProperty $targetPath).LastWriteTime)) {
        $pre = (Get-ItemProperty $targetPath).LastWriteTime
        cls

        $raw = Get-Content -Path $targetPath -Raw
        Write-Host -NoNewline "最終更新日時 = $pre `n----------------------------------`n$raw" 
    }
    Start-Sleep -Seconds 1 
}