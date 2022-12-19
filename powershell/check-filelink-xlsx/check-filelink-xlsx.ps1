$targetPath = $Args[0]

$files = Get-ChildItem -Recurse -LiteralPath $targetPath | ? { $_.Extension -like '*.xlsx' }

try {
    foreach ($f in $files) {
        $tempDir = New-TemporaryFile | % { rm $_; mkdir $_ }
        Write-Host '■CHECKING'$f
        Expand-Archive -LiteralPath $f.FullName -DestinationPath $tempDir.FullName -Force
        $tempFolder = Join-Path $tempDir.FullName 'xl/worksheets/_rels'
        $sheets = Get-ChildItem -Recurse -LiteralPath $tempFolder | ? { $_.Extension -like '*.rels' }
        foreach ($s in $sheets) {
            Write-Host 'SHEET'$s.PSChildName
            $XML = [XML](Get-Content  -Encoding UTF8  $s)
            foreach ($n in $XML.Relationships.Relationship) {
                if (!($n.TargetMode -eq 'External')) {
                    continue;
                }
                if ($n.Target.StartsWith('file:///')) { 
                    $link = $n.Target.Substring('file:///'.Length)
                }
                else {
                    $link = $n.Target
                }
                
                if (!(split-path $link -IsAbsolute)) {
                    $parent = Split-Path -Parent $f
                    $link = Join-Path $parent  $link
                }
                if (!(Test-Path $link)) {
                    Write-Host '[DEADLINK]' $link
                }
            }
        }
        $tempDir | ? { Test-Path $_ } | % { ls $_ -File -Recurse | rm; $_ } | rmdir -Recurse  
    }
}
catch {
    Write-Output 'Something threw an exception'
    Write-Output $_
}     


