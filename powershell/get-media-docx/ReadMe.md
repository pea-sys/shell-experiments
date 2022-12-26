# get-media-docx

引数で渡されたフォルダパスまたはファイルパスに含まれる  
docx 形式ファイルに埋め込まれたメディアファイルを抽出します。  
外部挿入リンクにより挿入されたメディアは抽出しません。

- example-1

```shell
pwsh get-media-docx.ps1 {targetFolder}
```

- example-2

```shell
pwsh get-media-docx.ps1 {targetFile}
```

- sample output

```shell
get-media-docx.ps1 work
[Output]
C:\Users\user\source\repos\shell-experiments\powershell\get-media-docx\work\media\1
C:\Users\user\source\repos\shell-experiments\powershell\get-media-docx\work\media\2
```

[備考]  
現状,PowerShell のみ対応  
WindowsPowerShell は未対応

docx を解凍すると、次のファイルが展開されます。

```
C:.
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
│  ├─media
│  │      image1.png
│  │      model3d1.glb
│  │
│  ├─theme
│  │      theme1.xml
│  │
│  └─_rels
│          document.xml.rels
│
└─_rels
        .rels
```

本スクリプトは media フォルダのみを抽出し、docx のファイル名称のフォルダに格納します。
