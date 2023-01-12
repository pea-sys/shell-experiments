# null 破棄ベンチマーク

「PowerShell 実践ガイドブック」ISBN978-4-8399-6598-3C3055 の null 破棄ベンチマークを試してみます。  
ガベージコレクションを測定対象に含めないようにする必要があります。

null 破棄の方法は,以下があります。
<式> | Out-Null 　以外は大差ないです。

- <式> > $null

```shell
$i=1;
$m=0;
$count=1000;
[System.GC]::Collect();
[System.GC]::WaitForPendingFinalizers();
while ($i -le $count) {
    $m+=(Measure-Command {$(1..100000) >$null}).TotalMilliseconds;
    $i++;
};
$m/$count;
13.9968886
```

- $null = <式>

```shell
 $i=1;
 $m=0;
 $count=1000;
 [System.GC]::Collect();
 [System.GC]::WaitForPendingFinalizers();
 while ($i -le $count) {
    $m+=(Measure-Command {$($null = (1..100000))}).TotalMilliseconds;$i++;
    };
$m/$count;
11.9100392
```

- [void]<式>

```shell
$i=1;
$m=0;
count=1000;
[System.GC]::Collect();
[System.GC]::WaitForPendingFinalizers();
while ($i -le $count) {
    $m+=(Measure-Command {$([void](1..100000))}).TotalMilliseconds;$i++;
    };
$m/$count;
11.3260114
```

- <式> | Out-Null

```shell
$i=1;
$m=0;
$count=1000;
[System.GC]::Collect();
[System.GC]::WaitForPendingFinalizers();
while ($i -le $count) {
    $m+=(Measure-Command {$(1..100000) | Out-Null}).TotalMilliseconds;
    $i++;
};
$m/$count;

22.8158617
```
