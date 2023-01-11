Add-Type -AssemblyName System.IO.Compression.Filesystem

param($targetPath)

if ([string]::IsNullorEmpty($Args[0])) {
    Write-Host '[Example]'
    Write-Host  $myInvocation.MyCommand.name '<TargetFile|TargetDirectory>'
    return
}

$files = Get-ChildItem -Recurse -LiteralPath $targetPath | ? { $_.Extension -like '*.xlsx' }

try {
    foreach ($f in $files) {
        Write-Host '■CHECKING'$f.FullName
        $compressed = [IO.Compression.Zipfile]::OpenRead($f.FullName)
        $sheets = $compressed.Entries | Where-Object { $_.FullName -like 'xl/worksheets/_rels/sheet*.xml.rels' }

        foreach ($sheet in $sheets) {
            Write-Host 'SHEET'$sheet.Name
            $stream = $sheet.Open()
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
                    Write-Host '[DEADLINK]' $link
                }
            }
        }
        $reader.Close()
        $stream.Close()
        $compressed.Dispose()
    }
}
catch {
    Write-Output 'Something threw an exception'
    Write-Output $_
}     


