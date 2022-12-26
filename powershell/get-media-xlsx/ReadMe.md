# get-media-xlsx

引数で渡されたフォルダパスまたはファイルパスに含まれる  
xlsx 形式ファイルに埋め込まれたメディアファイルを抽出します。  
外部挿入リンクにより挿入されたメディアは抽出しません。

- example-1

```shell
pwsh get-media-xlsx.ps1 {targetFolder}
```

- example-2

```shell
pwsh get-media-xlsx.ps1 {targetFile}
```

- sample output

```shell
get-media-xlsx.ps1 work
[Output]
C:\Users\user\source\repos\get-media-xlsx\work\media\1
C:\Users\user\source\repos\get-media-xlsx\work\media\2
```

[備考]  
PowerShell のみ対応  
WindowsPowerShell は未対応

xlsx を解凍すると、次のファイルが展開されます。

```
C:.
│ [Content_Types].xml
│
├─docProps
│ app.xml
│ core.xml
│
├─xl
│ │ styles.xml
│ │ workbook.xml
│ │
│ ├─diagrams
│ │ colors1.xml
│ │ data1.xml
│ │ drawing1.xml
│ │ layout1.xml
│ │ quickStyle1.xml
│ │
│ ├─drawings
│ │ │ drawing1.xml
│ │ │ drawing2.xml
│ │ │
│ │ └─_rels
│ │ drawing1.xml.rels
│ │ drawing2.xml.rels
│ │
│ ├─media
│ │ image1.png
│ │ image2.svg
│ │ image3.png
│ │ image4.svg
│ │ image5.png
│ │ image6.svg
│ │
│ ├─printerSettings
│ │ printerSettings1.bin
│ │
│ ├─theme
│ │ theme1.xml
│ │
│ ├─worksheets
│ │ │ sheet1.xml
│ │ │ sheet2.xml
│ │ │
│ │ └─_rels
│ │ sheet1.xml.rels
│ │ sheet2.xml.rels
│ │
│ └─_rels
│ workbook.xml.rels
│
└─_rels
.rels

```

本スクリプトは media フォルダのみを抽出し、xlsx のファイル名称のフォルダに格納します。
