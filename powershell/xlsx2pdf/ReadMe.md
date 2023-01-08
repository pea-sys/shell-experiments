# xlsx2pdf

引数で渡されたフォルダパスまたはファイルパスに含まれる  
xlsx 形式ファイルを一律 pdf 形式ファイル に変換するスクリプト  
フォルダパスを引数として渡した場合、サブフォルダも含めて処理します  
出力ファイルは「ファイル名\_シート名.pdf」です

---

- example-1

```shell
pwsh xlsx2pdf.ps1 {targetFolder}
```

- example-2

```shell
pwsh xlsx2pdf.ps1 {targetFile}
```

[備考]  
Excel に挿入した SmartArt のうちデフォルト表示されているテキストは pdf に記録されない仕様のようです。
