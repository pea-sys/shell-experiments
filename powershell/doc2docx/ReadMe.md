# doc2docx

引数で渡されたフォルダパスまたはファイルパスに含まれる  
doc 形式ファイルを一律 docx 形式ファイル(圧縮形式) に変換するスクリプト  
フォルダパスを引数として渡した場合、サブフォルダも含めて処理します

> ※マクロ文書は考慮していません  
> 　変換前ファイルを残します

---

- example-1

```shell
powershell doc2docx.ps1 {targetFolder}
```

- example-2

```shell
powershell doc2docx.ps1 {targetFile}
```
