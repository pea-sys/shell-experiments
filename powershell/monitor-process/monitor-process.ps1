param (
    [string]$targetProcessName,
    [int]$monitorIntervalSeconds,
    [string]$outputFilePath  # 出力ファイルのパスを追加
)

if (-not $targetProcessName) {
    Write-Host "プロセス名を指定してください。"
    exit
}

if (-not $monitorIntervalSeconds) {
    $monitorIntervalSeconds = 5  # デフォルトの監視間隔（秒数）
}

# 出力ファイルを作成または追記モードで開く
$null = New-Item -Path $outputFilePath -ItemType File -Force

function Log($message) {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "$timestamp - $message"
    Add-Content -Path $outputFilePath -Value $logEntry
}

# プロセスが起動するまで待機
while ($true) {
    $process = Get-Process -Name $targetProcessName -ErrorAction SilentlyContinue
    if ($process -ne $null) {
        Log "$targetProcessName が起動しました."
        break
    }
    Start-Sleep -Seconds 1  # 1秒ごとに確認
}

# プロセスが起動したら監視を開始
while ($true) {
    $process = Get-Process -Name $targetProcessName -ErrorAction SilentlyContinue
    if ($null -eq $process) {
        Log "$targetProcessName が終了しました."
        break
    }
    if ($process.Responding -eq $false) {
        Log "$targetProcessName が応答しなくなりました."
        # ここで必要な対処を実行するか、プロセスを再起動するなどのアクションを実行できます
        break
    }
    Start-Sleep -Seconds $monitorIntervalSeconds  # 監視間隔を引数から受け取る
}
