Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Windows.Forms
$patternRepeat = 1 #all pattern repeat count
$samplingRate = 10 #color sampling RANGE 1<=256 
$continuous = 10 #same pixcel continuous
$colorNum = [int](256 / $samplingRate)
$size = [int](([Math]::Sqrt($colorNum * $colorNum * $colorNum)) + 0.5)
$bmp = New-Object -TypeName System.Drawing.Bitmap -ArgumentList  $($size * $continuous), $($size * $patternRepeat)
$x = 0
$y = 0
$colorLimit = 256 - $samplingRate

#$ms = [System.IO.MemoryStream]::new()
#$bw = [System.IO.BinaryWriter]::new($ms)

#MAX SIZE:Single Thread 4min46sec
Measure-Command {
    for ($p = 0; $p -lt $patternRepeat; $p++) {
        for ($r = 0; $r -le $colorLimit; $r = $r + $samplingRate) {
            for ($g = 0; $g -le $colorLimit; $g = $g + $samplingRate) {
                for ($b = 0; $b -le $colorLimit; $b = $b + $samplingRate) {
                    for ($c = 0; $c -lt $continuous; $c++) {
                        $bmp.SetPixel($x, $y, [System.Drawing.Color]::FromArgb($r, $g, $b))
                        $x++;
                        if ($x -ge $bmp.Width) {
                            $x = 0
                            $y++;
                        }
                    }
                }
            }
        }  
    }
}
$fileName = (Get-Date -UFormat "%Y%m%d%H%M%S")
$output = (Join-Path $PSScriptRoot $fileName)
#[System.Drawing.Imaging.ImageFormat]::MemoryBmp is Png
$bmp.Save($output + '.bmp', [System.Drawing.Imaging.ImageFormat]::Bmp)
$bmp.Save($output + '.png', [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Save($output + '.jpg', [System.Drawing.Imaging.ImageFormat]::Jpeg)
$bmp.Save($output + '.tif', [System.Drawing.Imaging.ImageFormat]::Tiff)
$bmp.Save($output + '.gif', [System.Drawing.Imaging.ImageFormat]::Gif)
$bmp.Save($output + '.heif', [System.Drawing.Imaging.ImageFormat]::Heif)
$bmp.Save($output + '.webp', [System.Drawing.Imaging.ImageFormat]::Webp)
$bmp.Save($output + '.wmf', [System.Drawing.Imaging.ImageFormat]::Wmf)
$bmp.Save($output + '.emf', [System.Drawing.Imaging.ImageFormat]::Emf)
$bmp.Save($output + '.exif', [System.Drawing.Imaging.ImageFormat]::Exif)
$rect = New-Object System.Drawing.Rectangle(0, 0, $bmp.Width, $bmp.Height);
$convPng = $bmp.Clone($rect, [System.Drawing.Imaging.PixelFormat]::Format1bppIndexed)
$convPng.Save($output + '_1bit.png', [System.Drawing.Imaging.ImageFormat]::png)
$convPng = $bmp.Clone($rect, [System.Drawing.Imaging.PixelFormat]::Format4bppIndexed)
$convPng.Save($output + '_4bit.png', [System.Drawing.Imaging.ImageFormat]::png)
$convPng = $bmp.Clone($rect, [System.Drawing.Imaging.PixelFormat]::Format8bppIndexed)
$convPng.Save($output + '_8bit.png', [System.Drawing.Imaging.ImageFormat]::png)
$convPng.Dispose()
$bmp.Dispose()
<#
$form = New-Object System.Windows.Forms.Form 
$form.Size = New-Object System.Drawing.Size -ArgumentList  $size, $size
$pic = New-Object System.Windows.Forms.PictureBox
$pic.Size = New-Object System.Drawing.Size -ArgumentList  $size, $size
$pic.Image = [System.Drawing.Image]::FromFile($output)
$pic.Location = New-Object System.Drawing.Point -ArgumentList 0, 0 
$form.Controls.Add($pic) 

$result = $form.ShowDialog()
$pic.Image.Dispose()
$pic.Image = $null
#>