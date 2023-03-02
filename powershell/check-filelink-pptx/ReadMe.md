# check-filelink-pptx

引数で渡されたフォルダパスまたはファイルパスに含まれる  
pptx 形式ファイルに含まれるファイルリンクのリンク先ファイルが存在するかチェックするスクリプト

- example-1

```shell
powershell check-filelink-pptx.ps1 {targetFolder}
```

- example-2

```shell
powershell check-filelink-pptx.ps1 {targetFile}
```

- sample-output

```powershell
check-filelink-pptx.ps1 work
■CHECKING C:\Users\user\source\repos\check-filelink-pptx\work\1.pptx
SLIDE slide1.xml.rels
[DEADLINK] C:\Users\user\source\repos\check-filelink-pptx\work\images\image2.png
[DEADLINK] C:\Users\user\source\repos\check-filelink-pptx\work\images\image2.png
SLIDE slide2.xml.rels
■CHECKING C:\Users\user\source\repos\check-filelink-pptx\work\2\2.pptx
SLIDE slide1.xml.rels
SLIDE slide2.xml.rels
[DEADLINK] C:\Users\user\source\repos\check-filelink-pptx\work\2\sample.txt
```

[備考]

- PowerShell で使用可能  
  ※少し編集すれば unzip コマンド が使える環境でも使用可能
- 挿入リンクとフィールドの挿入によって追加されたリンク、ハイパーリンクをチェック対象にしています

* sample.pptx ファイルを解凍すると pptx 構成ファイルが展開されます。\_rels/document.xml.rels に記述されている外部ファイル挿入リンクに一致するパスにファイルが存在するかチェックします。

```
C:.
│  [Content_Types].xml
│
│
├─docProps
│      app.xml
│      core.xml
│      thumbnail.jpeg
│
├─ppt
│  │  presentation.xml
│  │  presProps.xml
│  │  tableStyles.xml
│  │  viewProps.xml
│  │
│  ├─slideLayouts
│  │  │  slideLayout1.xml
│  │  │  slideLayout10.xml
│  │  │  slideLayout11.xml
│  │  │  slideLayout2.xml
│  │  │  slideLayout3.xml
│  │  │  slideLayout4.xml
│  │  │  slideLayout5.xml
│  │  │  slideLayout6.xml
│  │  │  slideLayout7.xml
│  │  │  slideLayout8.xml
│  │  │  slideLayout9.xml
│  │  │
│  │  └─_rels
│  │          slideLayout1.xml.rels
│  │          slideLayout10.xml.rels
│  │          slideLayout11.xml.rels
│  │          slideLayout2.xml.rels
│  │          slideLayout3.xml.rels
│  │          slideLayout4.xml.rels
│  │          slideLayout5.xml.rels
│  │          slideLayout6.xml.rels
│  │          slideLayout7.xml.rels
│  │          slideLayout8.xml.rels
│  │          slideLayout9.xml.rels
│  │
│  ├─slideMasters
│  │  │  slideMaster1.xml
│  │  │
│  │  └─_rels
│  │          slideMaster1.xml.rels
│  │
│  ├─slides
│  │  │  slide1.xml
│  │  │  slide2.xml
│  │  │
│  │  └─_rels                    ←　解析対象
│  │          slide1.xml.rels
│  │          slide2.xml.rels
│  │
│  ├─theme
│  │      theme1.xml
│  │
│  └─_rels
│          presentation.xml.rels
│
└─_rels
        .rels
```
