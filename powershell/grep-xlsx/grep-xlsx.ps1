
Add-Type -AssemblyName System.IO.Compression.Filesystem

param($path, $pattern)

if ([string]::IsNullorEmpty($pattern)) {
    Write-Host '[Example]'
    Write-Host  $myInvocation.MyCommand.name '<TargetFile|TargetDirectory>' '<searchPattern>'
    return
}

$files = Get-ChildItem -Recurse -LiteralPath $path | ? { $_.Extension -like '*.xlsx' }
foreach ($file in $files) {   
    $compressed = [IO.Compression.Zipfile]::OpenRead($file.FullName)

    $sheets = $compressed.Entries | Where-Object { $_.Fullname -like "xl/worksheets/sheet*.xml" }
    $total = 0
    #sheets loop
    foreach ($sheet in $sheets) {
        $stream = $sheet.Open()
        $reader = New-object System.IO.StreamReader -ArgumentList $stream
        $xml = [xml]($reader.ReadToEnd())
        $reader.Close()
        $reader.Dispose()
        $stream.Close()
        $stream.Dispose()
            
        $sheetdata = $xml.GetElementsByTagName('sheetData')[0]
        $r = $xml.worksheet.sheetData.row.r
        $r_cursor = 0
        $c = $xml.worksheet.sheetData.row.c.r
        $c_cursor = 0
        #rows loop
        foreach ($row in $sheetdata.ChildNodes) {
            #cells loop
            foreach ($cell in $row.ChildNodes) {
                if ($cell.InnerText.ToString().Contains($pattern)) {
                    '{0}.{1} ({2}:{3}) = {4}' -f $file.PSChildName, $sheet.Name.Replace('.xml', ''), $r[$r_cursor], $c[$c_cursor], $cell.InnerText | 
                    Write-Host -ForegroundColor Cyan
                    $total += 1
                }
                $c_cursor++
            }
            $r_cursor++
        }
        if ($total) {
            "========== {0} ==========" -f $total | Write-Host -ForegroundColor Cyan
        }
    }
    $compressed.Dispose()
}



