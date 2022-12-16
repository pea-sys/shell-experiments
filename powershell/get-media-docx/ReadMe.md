# get-media-docx

引数で渡されたフォルダパスまたはファイルパスに含まれる  
docx 形式ファイルに埋め込まれたメディアファイルを吸出します。

- example-1

```shell
powershell get-media-docx.ps1 {targetFolder}
```

- example-2

```shell
powershell get-media-docx.ps1 {targetFile}
```

- sample output

```shell
get-media-docx.ps1 work

    Directory: C:\Users\user\source\repos\get-media-docx\work

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d----          2022/12/17     7:57                media
C:\Users\user\AppData\Local\Temp\tmp84C1.tmp
C:\Users\user\source\repos\get-media-docx\work\media\1
C:\Users\user\AppData\Local\Temp\tmp8790.tmp
C:\Users\user\source\repos\get-media-docx\work\media\2
```

[備考]  
現状,PowerShell7.0 のみ対応  
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
