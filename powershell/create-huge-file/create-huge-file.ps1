
$size = 1GB
$path = "$env:temp\hugefile"
$drive = $path.Split(":").Get(0)

$file_system_limit = switch ((Get-Volume  $drive).FileSystemType) {
    'NTFS' { 256TB }
    'exFAT' { 256TB }
    'FAT32' { 4GB }
    'FAT16' { 4GB }
    Default { 2GB }
} 

if ($size -gt ((Get-PSDrive $drive).Free * 0.95)) {
    Write-Host "Not enough free space in $drive drive"
    return
}
elseif ($size -gt $file_system_limit) {
    Write-Host "File size limit exceeded"
    return
}
$stream = New-Object System.IO.FileStream($Path, [System.IO.FileMode]::CreateNew)
$stream.Seek($size, [System.IO.SeekOrigin]::Begin)
$stream.WriteByte(0)
$stream.close()
$stream.dispose()
explorer.exe "/select,$path" 