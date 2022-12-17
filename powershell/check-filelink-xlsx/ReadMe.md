# check-filelink-xlsx

引数で渡されたフォルダパスまたはファイルパスに含まれる  
xlsx 形式ファイルに含まれるファイルリンクが有効化チェックするスクリプト

- example-1

```powershell
C:\Users\user\source\repos\check-filelink-xlsx\check-filelink-xlsx.ps1 C:\Users\user\source\repos\check-filelink-xlsx\work
■CHECKING C:\Users\user\source\repos\check-filelink-xlsx\work\1.xlsx
SHEET sheet1.xml.rels
[DEADLINK] C:\Users\user\source\repos\check-filelink-xlsx\work\2\2.xlsx
[DEADLINK] C:\Users\user\source\repos\check-filelink-xlsx\work\2\2.docx
SHEET sheet2.xml.rels
[DEADLINK] C:\Users\user\source\repos\check-filelink-xlsx\work\1.txt
■CHECKING C:\Users\user\source\repos\check-filelink-xlsx\work\[2]\[2].xlsx
SHEET sheet1.xml.rels
[DEADLINK] C:\Users\user\source\repos\check-filelink-xlsx\work\[2]\sample.txt
PS C:\Users\user>
```

[備考]

- PowerShell 7 で使用可能  
  ※少し編集すれば unzip コマンド が使える環境でも使用可能
- 挿入リンクとフィールドの挿入によって追加されたリンク、ハイパーリンクをチェック対象にしています

* sample.xlsx ファイルを解凍すると xlsx 構成ファイルが展開されます。xl/worksheets/\_rels/sheet{number}.xml.rels に記述されている外部ファイル挿入リンクに一致するパスにファイルが存在するかチェックします。

```
C:.
│  sample.xlsx
│  [Content_Types].xml
│
├─docProps
│      app.xml
│      core.xml
│
├─xl
│  │  sharedStrings.xml
│  │  styles.xml
│  │  workbook.xml
│  │
│  ├─printerSettings
│  │      printerSettings1.bin
│  │
│  ├─theme
│  │      theme1.xml
│  │
│  ├─worksheets
│  │  │  sheet1.xml
│  │  │
│  │  └─_rels
│  │          sheet1.xml.rels ← 解析対象(シートの数だけ展開される)
│  │
│  └─_rels
│          workbook.xml.rels
│
└─_rels
        .rels

```
