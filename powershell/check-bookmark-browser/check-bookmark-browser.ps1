 
$browsers = @{
    "GoogleChrome"  = "C:\Users\user\AppData\Local\Google\Chrome\User Data\Default\Bookmarks"
    "MicrosoftEdge" = "C:\Users\user\AppData\Local\Microsoft\Edge\User Data\Default\Bookmarks"
}
foreach ($browser in $browsers.Keys) {
    $json = (Get-Content $browsers[$browser] | ConvertFrom-Json)
    foreach ($child in  $json.roots.bookmark_bar.children) {
        try { 
            [System.Net.HttpWebRequest]$REQUEST = [System.Net.WebRequest]::Create($child.url)
            $res = $REQUEST.GetResponse()
        }
        catch {
            $errCode = $_.Exception.Response.StatusCode.Value__
            $errDesc = $_.Exception.Response.StatusDescription
        }
        if ([string]::IsNullOrEmpty($errCode)) { 
            Write-Host ("[{0}]:{1}:{2}" -f $res.StatusCode, $browser, $child.name)
        }
        else {
            Write-Host "Status:" $errCode $child.name
            Write-Host "Description:" $errDesc
        }
        Start-Sleep 2
    }
    
}

