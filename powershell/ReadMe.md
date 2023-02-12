# 実験環境

- Windows10
- PowerShell 7.3.1  
  ※WindowsPowerShell ではなく、クロスプラットフォームの高機能な PowerShell を使用しています。  
   インストーラはこちらから入手可能です。  
   https://github.com/PowerShell/PowerShell/releases

* WindowsPowerShell

[備考]  
スクリプトによっては実行不可な環境があります(下記参照)

---

## 動作環境

| スクリプト             | 説明                                             | Desktop(WindowsPowerShell) | Core(PowerShell) | 備考                               |
| ---------------------- | ------------------------------------------------ | -------------------------- | ---------------- | ---------------------------------- |
| check-filelink-xlsx    | xlsx に埋め込まれたリンクの死活チェック          | ×                          | 〇               |                                    |
| check-filelink-docx    | docx に埋め込まれたリンクの死活チェック          | ×                          | 〇               |                                    |
| check-bookmark-browser | ブラウザブックマークの死活チェック               | ×                          | 〇               | インナーリンクの死活チェック未対応 |
| docx2pdf               | docx を pdf に変換                               | 〇                         | 〇               |                                    |
| xlsx2pdf               | xlsx を pdf に変換                               | 〇                         | 〇               |                                    |
| doc2docx               | doc を docx に変換                               | 〇                         | 〇               |
| xls2xlsx               | xls を xlsx に変換                               | 〇                         | 〇               |                                    |
| ppt2pptx               | ppt を pptx に変換                               | 〇                         | ×                |                                    |
| off-on-network-adapter | ネットワークアダプトの定期的な切替スイッチ       | ×                          | 〇               |                                    |
| grep-xlsx              | xlsx の grep 検索                                | 〇                         | 〇               |                                    |
| grep-docx              | docx の grep 検索                                | 〇                         | 〇               |                                    |
| get-media-xlsx         | xlsx から media ファイルを抽出                   | ×                          | 〇               |                                    |
| get-media-docx         | docx から media ファイルを抽出                   | ×                          | 〇               |                                    |
| folder-structure       | 対象ディレクトリの拡張子別サイズのチャート図出力 | ×                          | 〇               | gitignore 機能未完                 |
| file-watcher           | 対象ディレクトリのファイル操作モニタリング       | 〇                         | 〇               |                                    |
| file-liveview          | 対象ファイルのライブビュー                       | 〇                         | 〇               |                                    |
| create-image           | 各フォーマットの画像生成                         | 〇                         | 〇               |                                    |
