param($targetPath)

if ([string]::IsNullorEmpty($targetPath)) {
    Write-Host '[Example]'
    Write-Host  $myInvocation.MyCommand.name '<TargetFile|TargetDirectory>'
    return
}

$files = Get-ChildItem -Recurse -LiteralPath $targetPath | ? { $_.Extension -like '*.xlsx' }
 
$excel = New-Object -ComObject Excel.Application
$excel.DisplayAlerts = $false

foreach ($f in $files) {
    $books = $excel.workbooks.Open($f.FullName, 0, $true)
    for ( $i = 1; $i -le $books.Sheets.Count; $i++ ) {
        $sheetName = $books.Sheets($i).Name
        $books.Sheets($i).ExportAsFixedFormat(0, $f.FullName.Replace('.xlsx', "_$sheetName.pdf"))
    }
    
    $books.Close()
}
$excel.DisplayAlerts = $true
$excel.Quit()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($excel) > $null
$excel = $null

Remove-Variable -Name excel -ErrorAction SilentlyContinue
[System.GC]::Collect()
[System.GC]::WaitForPendingFinalizers()
