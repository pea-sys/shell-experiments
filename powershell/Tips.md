# PowerShell 使用時の注意点

- Copy-Item コマンドは使用しないこと・・・Copy 先フォルダが存在するかどうかでコピーする階層が異なります。再現性が得られないので、robocopy 等を利用する。

* Update-Help -UICulture en-US・・・定期的にヘルプ更新コマンドを実行すること。日本語は 404 なので en-US を指定する。

* ダブルクォートよりシングルクォートを優先して使用する・・・ダブルクォートだと変数を実行時に展開する。シングルクォートは変数展開しない。
