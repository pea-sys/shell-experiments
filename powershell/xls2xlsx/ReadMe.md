# xls2xlsx

引数で渡されたフォルダパスまたはファイルパスに含まれる  
xls 形式ファイルを一律 xlsx 形式ファイル(圧縮形式) に変換するスクリプト  
フォルダパスを引数として渡した場合、サブフォルダも含めて処理します

> ※マクロ文書は考慮していません  
> 　変換前ファイルを残します

---

- example-1

```shell
powershell xls2xlsx.ps1 {targetFolder}
```

- example-2

```shell
powershell xls2xlsx.ps1 {targetFile}
```
