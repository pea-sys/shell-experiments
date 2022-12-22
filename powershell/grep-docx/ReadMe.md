# grep-docx

引数で渡されたフォルダパスまたはファイルパスに含まれる  
docx 形式ファイルを grep 検索するスクリプト  
今回は私が書くより遥に綺麗なコードが Qiita にあったので  
そちらを流用しています。

[【powershell】MS Word を開かずに内容を取得する](https://qiita.com/AWtnb/items/b70610f78b20adc46765)

@AWtnb さんありがとうございます。

- example-1

```shell
powershell grep-docx.ps1 {targetFolder} {word}
```
