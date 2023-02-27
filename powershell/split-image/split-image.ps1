
param([String]$targetPath, [Int]$splitCount)

if ([string]::IsNullorEmpty($targetPath) -or ($splitCount -le 0)) {
    Write-Host '[Example]'
    Write-Host  $myInvocation.MyCommand.name '<TargetFile> <SplitCount>'
    return
}
if (!(Test-Path $targetPath)) {
    Write-Host 'Not Found TargetFile'
    return
}

Add-Type -AssemblyName System.Drawing

$image = New-Object System.Drawing.Bitmap -ArgumentList $targetPath
$single_height = $image.Height
$single_width = $image.Width

$vertical = $null
if ($image.Width -gt $image.Height) {
    $single_width /= $splitCount
    $vertical = $false
}
else {
    $single_height /= $splitCount
    $vertical = $true
}
$basePath = [IO.Path]::GetFileNameWithoutExtension($targetPath)
$parentPath = Split-Path $targetPath -Parent
$index = 0
while ($splitCount -gt $index) {
    if ($vertical) {
        $rect = New-Object System.Drawing.Rectangle(0, ($index * $single_height), $single_width, $single_height)
    }
    else {
        $rect = New-Object System.Drawing.Rectangle(($index * $single_width), 0, $single_width, $single_height)
    }
    #$single_image = $image.Clone($rect , [System.Drawing.Imaging.PixelFormat]::Format8bppIndexed)
    #$single_image = $image.Clone($rect , [System.Drawing.Imaging.PixelFormat]::Format4bppIndexed)
    #$single_image = $image.Clone($rect , [System.Drawing.Imaging.PixelFormat]::Format1bppIndexed)
    $single_image = $image.Clone($rect , $image.PixelFormat)
    $output = $basePath + $index + ".png"
    $output = Join-Path $parentPath $output
    $single_image.Save($output, [System.Drawing.Imaging.ImageFormat]::png)
    $single_image.Dispose()
    $index++
}
$image.Dispose()