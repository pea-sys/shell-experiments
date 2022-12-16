$targetPath = $Args[0]

if ($PSVersionTable.PSVersion.Major -ne 7) {
    Write-Host "Not Supported PowerShell Version"
    exit
}

$files = Get-ChildItem -Recurse -LiteralPath $targetPath | ? { $_.Extension -like "*.docx" }
if (Test-Path $targetPath -PathType Leaf) {
    $targetParent = Split-Path -Parent $targetPath
    $outputDir = Join-Path $targetParent "media"
}
else {
    $outputDir = Join-Path $targetPath "media"
}
if (!(Test-Path $outputDir)) {
    New-Item  $outputDir -ItemType Directory
}

$word = New-Object -ComObject Word.Application
     
foreach ($f in $files) {
    $tempDir = New-TemporaryFile | % { rm $_; mkdir $_ }
    Write-Host $tempDir.FullName
    Expand-Archive -LiteralPath $f.FullName -DestinationPath $tempDir.FullName

    $src = Join-Path $tempDir.FullName "word\media"
    $name = [System.IO.Path]::GetFileNameWithoutExtension($f)
    $dist = Join-Path $outputDir $name
    Write-Host $dist
    Copy-Item -LiteralPath $src -Destination $dist -Force  -Recurse
    $tempDir | ? { Test-Path $_ } | % { ls $_ -File -Recurse | rm; $_ } | rmdir -Recurse 
}

$word.Quit()

  