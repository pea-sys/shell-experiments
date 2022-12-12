$targetPath = $Args[0]

$files = Get-ChildItem -Recurse -LiteralPath $targetPath | ? { $_.Extension -like "*.xls" }

$tempDir = New-TemporaryFile | % { rm $_; mkdir $_ }
Write-Host $tempDir.FullName

$exlFormatDocumentDefault = 51
 
$excel = New-Object -ComObject Excel.Application
$excel.DisplayAlerts = false


foreach ($f in $files) {
    Write-Host $f
    $parent = Split-Path -Parent $f.FullName
    $books = $excel.workbooks.Open($f.FullName, 0, $true)
    $outputfile = $f.Name + "x"
    $outputfile = Join-Path $tempDir.FullName $outputfile
    Write-Host $outputfile
    # workbooks・ｽ・ｽSaveAs・ｽ・ｽ・ｽT・ｽu・ｽt・ｽH・ｽ・ｽ・ｽ_・ｽz・ｽ・ｽ・ｽﾌ禁止・ｽ・ｽ・ｽ・ｽ・ｽ・ｽ・ｽ・ｽG・ｽX・ｽP・ｽ[・ｽv・ｽﾅゑｿｽ・ｽﾈゑｿｽ・ｽ・ｽ・ｽﾟ、・ｽG・ｽX・ｽP・ｽ[・ｽv・ｽﾂ能・ｽﾈコ・ｽs・ｽ[・ｽ・ｽp・ｽ・ｽ・ｽﾄ間接的・ｽﾉ格・ｽ[
    $books.SaveAs([ref]$outputfile.ToString(), [ref]$exlFormatDocumentDefault)
    $dist = $f.FullName + "x"
    Copy-Item -LiteralPath $outputfile -Destination $dist -Force
    $books.Close()
}
$excel.DisplayAlerts = true
$excel.Quit()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($excel) | Out-Null
$excel = $null
$tempDir | ? { Test-Path $_ } | % { ls $_ -File -Recurse | rm; $_ } | rmdir -Recurse   
Remove-Variable -Name excel -ErrorAction SilentlyContinue
[System.GC]::Collect()
[System.GC]::WaitForPendingFinalizers()
