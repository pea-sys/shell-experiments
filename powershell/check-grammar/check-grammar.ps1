#Requires -PSEdition Core
param($targetPath)

if ([string]::IsNullorEmpty($targetPath)) {
    Write-Host '[Example]'
    Write-Host  $myInvocation.MyCommand.name '<TargetFile|TargetDirectory>'
    return
}

$files = Get-ChildItem -Recurse -LiteralPath $targetPath | ? { $_.Extension -in ".txt", ".log", ".md" }

foreach ($fn in $files) {
    $text = [String]::Join("`n", (get-content -encoding UTF8 $fn))

    $word = new-object -comObject "Word.Application"
    $word.Visible = $true

    $doc = $word.Documents.Add()

    $range = $doc.Content
    $range.Text = $text

    $doc.CheckGrammar()
}
