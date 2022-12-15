# docx-filelink-checker

引数で渡されたフォルダパスまたはファイルパスに含まれる  
docx 形式ファイルに含まれるファイルリンクが有効化チェックするスクリプト

- example-1

```powershell
■CHECKING C:\Users\user\source\repos\docx-filelink-checker\work\1.docx
[DEADLINK] C:\Users\user\source\repos\docx-filelink-checker\work\image3.png
[DEADLINK] C:\Users\user\source\repos\docx-deadlink\work\images\image.png
[DEADLINK] C:\Users\user\source\repos\docx-filelink-checker\work\image2.png
■CHECKING C:\Users\user\source\repos\docx-filelink-checker\work\2\2.docx
[DEADLINK] C:\Users\user\source\repos\docx-deadlink\work\%5b2%5d\images\image.png
```

[備考]

- PowerShell 7 で使用可能  
  ※少し編集すれば unzip コマンド が使える環境でも使用可能
- 挿入リンクとフィールドの挿入によって追加されたリンク、ハイパーリンクをチェック対象にしています

* sample.docx ファイルを解凍すると docx 構成ファイルが展開されます。\_rels/document.xml.rels に記述されている外部ファイル挿入リンクに一致するパスにファイルが存在するかチェックします。

```
C:.
│  sample.docx
│  [Content_Types].xml
│
├─docProps
│      app.xml
│      core.xml
│
├─word
│  │  document.xml
│  │  fontTable.xml
│  │  settings.xml
│  │  styles.xml
│  │  webSettings.xml
│  │
│  ├─theme
│  │      theme1.xml
│  │
│  └─_rels
│          document.xml.rels ←　解析対象
│
└─_rels
        .rels
```
