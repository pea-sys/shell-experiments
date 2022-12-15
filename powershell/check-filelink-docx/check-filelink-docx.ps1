$targetPath = $Args[0]

$files = Get-ChildItem -Recurse -LiteralPath $targetPath | ? { $_.Extension -like "*.docx" }

$tempDir = New-TemporaryFile | % { rm $_; mkdir $_ }
Write-Host "Create TemporaryFolder=" $tempDir
 
$word = New-Object -ComObject Word.Application
try {
    foreach ($f in $files) {
        Write-Host "■CHECKING"$f
        #& 'C:\Program Files\Git\usr\bin\unzip' -o $f.FullName -d $tempDir.FullName  | Out-Null
        Expand-Archive -LiteralPath $f.FullName -DestinationPath $tempDir.FullName -Force
        $tempFile = Join-Path $tempDir.FullName "word/_rels/document.xml.rels"
        $XML = [XML](Get-Content  -Encoding UTF8  $tempFile)
        foreach ($n in $XML.Relationships.Relationship) {
            if (!($n.TargetMode -eq "External")) {
                continue;
            }
            if ($n.Target.StartsWith("file:///")) { 
                $link = $n.Target.Substring("file:///".Length)
            }
            else {
                $link = $n.Target
            }
            
            if (!(split-path $link -IsAbsolute)) {
                $parent = Split-Path -Parent $f
                $link = Join-Path $parent  $link
            }
            if (!(Test-Path $link)) {
                Write-Host "[DEADLINK]"$link
            }
        }
    }
}
catch {
    Write-Output "Something threw an exception"
    Write-Output $_
}     
finally {
    $tempDir | ? { Test-Path $_ } | % { ls $_ -File -Recurse | rm; $_ } | rmdir -Recurse  
    Write-Host "Delete TemporaryFolder=" $tempDir
    $word.Quit()
}


