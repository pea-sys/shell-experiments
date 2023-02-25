
Add-Type -AssemblyName System.Windows.Forms

$parentDir = (Split-Path $MyInvocation.MyCommand.Path -Parent) + '\'
$clip = $null

while ($true) {
    Start-Sleep -Milliseconds 500 
    $clip = [Windows.Forms.Clipboard]::GetImage()
    if ($null -eq $clip) {
        Continue
    }

    $path = $parentDir + (Get-Date -Format "yyyyMMdd-HHmmssfff") + '.png'
    $clip.Save($path)
    [Windows.Forms.Clipboard]::Clear()
    Write-Host "$path"
}
