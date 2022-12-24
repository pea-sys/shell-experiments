# grep-xlsx

引数で渡されたフォルダパスまたはファイルパスに含まれる  
xlsx 形式ファイルを grep 検索するスクリプト

- example-1

```shell
pesh grep-exlx.ps1 {targetFolder} {word}
```

- exalmple

```shell
grep-xlsx.ps1 C:\Users\user\source\repos\grep-xlsx\work "111"
1.xlsx.sheet2 (2:B2) = 1111
1.xlsx.sheet2 (3:B3) = 1110
========== 2 ==========
1.xlsx.sheet1 (112:B112) = 111
1.xlsx.sheet1 (1111:B1111) = 1110
1.xlsx.sheet1 (1112:B1112) = 1111
1.xlsx.sheet1 (1113:B1113) = 1112
1.xlsx.sheet1 (1114:B1114) = 1113
1.xlsx.sheet1 (1115:B1115) = 1114
1.xlsx.sheet1 (1116:B1116) = 1115
1.xlsx.sheet1 (1117:B1117) = 1116
1.xlsx.sheet1 (1118:B1118) = 1117
1.xlsx.sheet1 (1119:B1119) = 1118
1.xlsx.sheet1 (1120:B1120) = 1119
========== 13 ==========
2.xlsx.sheet1 (6:H6) = 111
2.xlsx.sheet1 (14:J14) = 1111
========== 2 ==========
```
