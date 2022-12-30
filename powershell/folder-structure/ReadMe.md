# folder-structure

引数で与えられたフォルダーを拡張子別にサイズ計算します。  
スクリプト配置フォルダに円グラフのイメージファイルを出力します。  
個人的に、プロジェクトのリソース削減戦略を立てるために使用しています。

- example 1

```shell
pwsh folder-structure.ps1 {targetFolder}

Name                           Value
----                           -----
.js                            0.18
.gif                           0.16
.jpg                           0.14
.png                           0.13
.cs                            0.07
.idx                           0.05
.cpp                           0.04
.ico                           0.03
.exe                           0.02
.gcode                         0.02
others                         0.01
```

![20221230105412_PowerToys](https://user-images.githubusercontent.com/49807271/210027621-49b187ca-4d0c-4523-a0c4-c86d0e4bbaa8.png)
