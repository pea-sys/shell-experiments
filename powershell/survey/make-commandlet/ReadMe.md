# コマンドレットを作成する

PowerShell で使用するコマンドレットを作成します。  
ここでは、コマンドレットにキーを渡した回数を返すライブラリを作成します。

- 1.VisualStudio を起動し、クラスライブラリのプロジェクトを作成します。

![1](https://user-images.githubusercontent.com/49807271/223687050-52db075f-449b-4d67-acc4-d989143d1529.png)

- 2.パッケージマネージャーから System.Management.Automation をインストール

![2](https://user-images.githubusercontent.com/49807271/223676686-edf885fe-3280-4e6c-95e4-f5cd97f6cbcb.png)

- 3.コーディングします。

```cs
using System.Management.Automation;

namespace CoreSample
{
    [Cmdlet(VerbsCommon.Get, "CallCounter")]
    [OutputType(typeof(int))]
    public class GetCallCounter : PSCmdlet
    {
        [Parameter(Mandatory = false, Position = 0, ValueFromPipeline = false)]
        public string Caller { get; set; } = string.Empty;

        public static Dictionary<string, int> callCountDict = new Dictionary<string, int>();

        protected override void ProcessRecord()
        {
            if (callCountDict.ContainsKey(Caller))
            {
                callCountDict[Caller] += 1;
            }
            else
            {
                callCountDict.Add(Caller, 1);
            }
            WriteObject(callCountDict[Caller]);
        }
    }
}
```

- 4.プロジェクトを右クリックして「発行」を選択

![3](https://user-images.githubusercontent.com/49807271/223690139-008039b8-c5b1-485f-a09f-53014bf1d9f4.png)

- 5.ターゲットをフォルダーにします。

![4](https://user-images.githubusercontent.com/49807271/223694519-73807d07-7508-49a7-8018-329253c57fd0.png)

- 6.発行をクリック

![5](https://user-images.githubusercontent.com/49807271/223694819-50c5bc67-07be-4785-be19-689b4baf3d0f.png)

- 7.powershell を起動し、バイナリが発行されたフォルダに移動します

```pwsh
PS C:\Users\user\source\repos\CallCounter\CallCounter> cd C:\Users\user\source\repos\CallCounter\CallCounter\bin\Release\net7.0\publish
```

- 8.Module を読み込みます

```pwsh
PS C:\Users\user\source\repos\CallCounter\CallCounter\bin\Release\net7.0\publish> Import-Module C:\Users\user\source\repos\CallCounter\CallCounter\bin\Release\net7.0\publish\CallCounter.dll
Import-Module: Could not load file or assembly 'System.Management.Automation, Version=7.4.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'. 指定されたファイルが見つかりません。
```

エラーが出ました。
良く分かりませんが、dll のターゲットフレームワークと Powershell が動作するフレームワークのバージョンの差異から来ている問題だと思うので、最新の.NET Core 7 を使用して dll を作成せずに.NETCore6 を使用します。

- 9.再度、publish フォルダにバイナリを発行後、Module を読み込みます。  
  読込み成功しました。  
  ※フォルダは net7.0 になってますが、フレームワークは 6.0 です。

```pwsh
PS C:\Users\user\source\repos\CallCounter\CallCounter\bin\Release\net7.0\publish> Import-Module C:\Users\user\source\repos\CallCounter\CallCounter\bin\Release\net7.0\publish\CallCounter.dll
PS C:\Users\user\source\repos\CallCounter\CallCounter\bin\Release\net7.0\publish> Get-Module -Name CallCounter

ModuleType Version    PreRelease Name                                ExportedCommands
---------- -------    ---------- ----                                ----------------
Binary     1.0.0.0               CallCounter                         Get-CallCounter
```

- 10.実行してみます。

```pwsh
PS C:\Users\user\source\repos\CallCounter\CallCounter\bin\Release\net7.0\publish> Get-CallCounter FuncA
1
PS C:\Users\user\source\repos\CallCounter\CallCounter\bin\Release\net7.0\publish> Get-CallCounter FuncA
2
PS C:\Users\user\source\repos\CallCounter\CallCounter\bin\Release\net7.0\publish> Get-CallCounter FuncA
3
PS C:\Users\user\source\repos\CallCounter\CallCounter\bin\Release\net7.0\publish> Get-CallCounter FuncB
1
PS C:\Users\user\source\repos\CallCounter\CallCounter\bin\Release\net7.0\publish> Get-CallCounter FuncC
1
PS C:\Users\user\source\repos\CallCounter\CallCounter\bin\Release\net7.0\publish> Get-CallCounter FuncB
2
```

良さそうですね。Get-CallCounter コマンドレットの呼び出し回数が引数毎に集計されています。
