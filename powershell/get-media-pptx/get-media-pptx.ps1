#Requires -PSEdition Core
$targetPath = $Args[0]

$files = Get-ChildItem -Recurse -LiteralPath $targetPath | ? { $_.Extension -like "*.pptx" }
if (Test-Path $targetPath -PathType Leaf) {
    $targetPath = Split-Path -Parent $targetPath
}

$outputDir = Join-Path $targetPath "media"

New-Item  $outputDir -ItemType Directory -Force | Out-Null

Write-Host "[Output]"     

foreach ($f in $files) {
    $tempDir = New-TemporaryFile | % { rm $_; mkdir $_ }
    Expand-Archive -LiteralPath $f.FullName -DestinationPath $tempDir.FullName

    $src = Join-Path $tempDir.FullName "ppt\media"
    $name = [System.IO.Path]::GetFileNameWithoutExtension($f)
    $dist = Join-Path $outputDir $name
    Write-Host $dist
    Robocopy $src $dist | Out-Null
    $tempDir | ? { Test-Path $_ } | % { ls $_ -File -Recurse | rm; $_ } | rmdir -Recurse 
}

  