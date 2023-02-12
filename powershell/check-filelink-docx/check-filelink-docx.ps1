#Requires -PSEdition Core
param($targetPath)

Add-Type -AssemblyName System.IO.Compression.Filesystem

if ([string]::IsNullorEmpty($targetPath)) {
    Write-Host '[Example]'
    Write-Host  $myInvocation.MyCommand.name '<TargetFile|TargetDirectory>'
    return
}

$files = Get-ChildItem -Recurse -LiteralPath $targetPath | ? { $_.Extension -like '*.docx' }

try {
    foreach ($f in $files) {
        Write-Host '■CHECKING'$f.FullName
        $compressed = [IO.Compression.Zipfile]::OpenRead($f.FullName)
        $rels = $compressed.Entries | Where-Object { $_.FullName -like 'word/_rels/document.xml.rels' }
        $stream = $rels.Open()
        $reader = New-object System.IO.StreamReader -ArgumentList $stream
        $xml = [xml]($reader.ReadToEnd())
        $reader.Close()
        $reader.Dispose()
        $stream.Close()
        $stream.Dispose()

        foreach ($n in $xml.Relationships.ChildNodes) {
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
                Write-Host '[DEADLINK]'$link
            }
        }
        $compressed.Dispose()
    }
}
catch {
    Write-Output 'Something threw an exception'
    Write-Output $_
}     


