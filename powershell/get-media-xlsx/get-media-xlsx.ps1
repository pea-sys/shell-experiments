$targetPath = $Args[0]

$files = Get-ChildItem -Recurse -LiteralPath $targetPath | ? { $_.Extension -like '*.xlsx' }

if (Test-Path $targetPath -PathType Leaf) {
    $targetPath = Split-Path -Parent $targetPath
}

Write-Host "[Output]"     

foreach ($f in $files) {
    $compressed = [IO.Compression.Zipfile]::OpenRead($f.FullName)
    $medias = $compressed.Entries | Where-Object { $_.FullName -like 'xl/media/*' }
    $dist_parent = Join-Path $targetPath 'media' $f.Name.Replace('.xlsx', '')
    foreach ($m in $medias) {
        if (!(Test-Path $dist_parent)) {
            New-Item $dist_parent -ItemType Directory
        }
        $dist = Join-Path $dist_parent $m.Name

        if (!(Test-Path $dist)) {
            [System.IO.Compression.ZipFileExtensions]::ExtractToFile($m, $dist)
            Write-Host $dist
        }
    }
    $compressed.Dispose()
}

  