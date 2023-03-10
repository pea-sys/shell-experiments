
Add-Type -AssemblyName System.Drawing
$originalPath = Join-Path $PSScriptRoot 'origin.jpg'
$originImg = [System.Drawing.Image]::FromFile($originalPath)

$savePath = Join-Path $PSScriptRoot 'tmp_save.jpg'
$originImg.Save($savePath, [System.Drawing.Imaging.ImageFormat]::jpeg)
$updatePath = JOIN-Path $PSScriptRoot 'tmp_update.jpg'
$originImg.Save($updatePath, [System.Drawing.Imaging.ImageFormat]::jpeg)
$tmpPath = JOIN-Path $PSScriptRoot 'tmp.jpg'
$originImg.Save($tmpPath, [System.Drawing.Imaging.ImageFormat]::jpeg)
$originImg.Dispose()

$repeatCount = 100# SimpleSave
<#
foreach ($i in 0..$repeatCount) {
    $memoryByteArr = [System.IO.File]::ReadAllBytes($savePath)
    $stream = [System.IO.MemoryStream]::new($memoryByteArr)
    $fs = [System.Drawing.Image]::FromStream($stream)
    $fs.Save($savePath)
    $fs.Dispose()
    $stream.Close()
    $stream.Dispose()
}
#>
#EditSave
$quality = 100 #mspaint=30

Copy-Item -LiteralPath $updatePath -Destination $tmpPath
$myEncoder = [System.Drawing.Imaging.Encoder]::Quality
$encoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
$encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter($myEncoder, $quality)
$myImageCodecInfo = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | where { $_.MimeType -eq 'image/jpeg' }

foreach ($i in 0..$repeatCount) {
    $per = [Int]($i / $repeatCount * 100) 
    Write-Progress "処理中" -PercentComplete ($per)
    $updateImg = New-Object -TypeName System.Drawing.Bitmap($tmpPath)
    $x = Get-Random -Minimum 0 -Maximum $updateImg.Width
    $y = Get-Random -Minimum 0 -Maximum $updateImg.Height
    $r = Get-Random -Minimum 0 -Maximum 256
    $g = Get-Random -Minimum 0 -Maximum 256
    $b = Get-Random -Minimum 0 -Maximum 256
    $updateImg.SetPixel($x, $y, [System.Drawing.Color]::FromArgb($r, $g, $b))
    $updateImg.Save($updatePath, $myImageCodecInfo, $encoderParams)
    $updateImg.Dispose()
    Copy-Item -LiteralPath $updatePath -Destination $tmpPath -Force
}
Remove-Item $tmpPath -Force




