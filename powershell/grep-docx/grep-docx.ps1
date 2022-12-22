
#{ref}(https://qiita.com/AWtnb/items/b70610f78b20adc46765)
Add-Type -AssemblyName System.IO.Compression.Filesystem
function Get-TextOfDocxDocument {
    param (
        [string]$path
    )

    try {
        $fullPath = (Resolve-Path -Path $path).Path
        $compressed = [IO.Compression.Zipfile]::OpenRead($fullPath)

        $target = $compressed.Entries | Where-Object { $_.Fullname -eq "word/document.xml" }
        $stream = $target.Open()
        $reader = New-Object IO.StreamReader($stream)
        $content = $reader.ReadToEnd()

        $reader.Close()
        $stream.Close()
        $compressed.Dispose()

        $m = [regex]::Matches($content, "<w:p.*?>.*?</w:p>")
        return [PSCustomObject]@{
            Status = "OK"
            Lines  = @($m.value -replace "<.+?>", "")
        }
    }
    catch {
        return [PSCustomObject]@{
            Status = "FILEOPENED"
            Lines  = @()
        }
    }
}

function Invoke-GrepOnDocx {
    param (
        [string]$path,
        [string]$pattern,
        [switch]$case
    )

    $files = Get-ChildItem -Recurse -LiteralPath $path | ? { $_.Extension -like '*.docx' }
    foreach ($f in $files) {
        $docxContent = Get-TextOfDocxDocument -path $f.Fullname
        if ($docxContent.Status -eq "FILEOPENED") {
            Write-Error ("'{0}' is used by other process!" -f $f.FullName)
            return
        }
        $grep = $docxContent.Lines | Select-String -Pattern $pattern -AllMatches -CaseSensitive:$case
        foreach ($g in $grep) {
            $text = $g.Line
            if ($text.Length -gt 10) {
                $text = $text.Substring(0, 10)
            }
            Write-Host $f.Name $g.LineNumber $text 
        }
        $total = $grep.Matches.Count
        if ($total) {
            "========== {0} ==========" -f $total | Write-Host -ForegroundColor Cyan
        }
    }
}

Invoke-GrepOnDocx $Args[0], $Args[1], $false

