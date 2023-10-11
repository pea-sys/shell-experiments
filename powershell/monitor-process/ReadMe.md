# monitor-process

引数で渡されたプロセスの生死監視を行います

- example-1

```
PS C:\Users\user> monitor-process.ps1 -targetProcessName "notepad" -monitorIntervalSeconds 5 -outputFilePath pmon.log
```

監視結果はテキストに出力します

```
2023-10-01 15:53:33 - notepad が起動しました.
2023-10-01 15:54:09 - notepad が応答しなくなりました.
```
