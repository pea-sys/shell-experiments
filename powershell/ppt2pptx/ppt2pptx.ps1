param($targetPath)

if ([string]::IsNullorEmpty($targetPath)) {
    Write-Host '[Example]'
    Write-Host  $myInvocation.MyCommand.name '<TargetFile|TargetDirectory>'
    return
}

$files = Get-ChildItem -Recurse -LiteralPath $targetPath | ? { $_.Extension -like "*.ppt" }

$powerpoint = New-Object -ComObject PowerPoint.Application

foreach ($f in $files) {
    Write-Host $f

    $ppt = $powerpoint.Presentations.Open($f.FullName, [Microsoft.Office.Core.MsoTriState]::msoTrue, [Microsoft.Office.Core.MsoTriState]::msoFalse, [Microsoft.Office.Core.MsoTriState]::msoFalse)

    $outputfile = $f.FullName + "x"
    Write-Host $outputfile

    $ppt.SaveAs($outputfile, [Microsoft.Office.Interop.PowerPoint.PpSaveAsFileType]::ppSaveAsOpenXMLPresentation)

    $ppt.Close()
    $ppt = $null
}

$powerpoint.Quit()
$powerpoint = $null
[gc]::collect()
[gc]::WaitForPendingFinalizers()