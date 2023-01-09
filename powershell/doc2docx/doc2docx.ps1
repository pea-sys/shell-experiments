if ([string]::IsNullorEmpty($Args[0])) {
    Write-Host '[Example]'
    Write-Host  $myInvocation.MyCommand.name '<TargetFile|TargetDirectory>'
    return
}
else {
    $targetPath = $Args[0]
}
$files = Get-ChildItem -Recurse -LiteralPath $targetPath | ? { $_.Extension -like '*.doc' }

$wdFormatDocumentDefault = 16
 
$word = New-Object -ComObject Word.Application
     
foreach ($f in $files) {
    Write-Host $f

    $doc = $word.Documents.Open($f.FullName, $false, $true)

    $outputfile = $f.FullName + 'x'
    Write-Host $outputfile

    $doc.SaveAs2([ref]$outputfile, [ref]$wdFormatDocumentDefault)

    $doc.Close()
}

$word.Quit()
