# CSharp によるスクリプト作成

C#で Powershell スクリプトが記述できるらしい。
今回はそれを試す。

２つやり方があるので、それぞれ試します。

- 1.スクリプトに直接 C#を記述する
- 2.cs ファイルを powershell で読み込んで実行する

## ■ スクリプトに直接 C#を記述する

ps1 ファイルに次のように記述する

```ps
$csharp = @"
    任意のC#コード
"@
Add-Type -TypeDefinition $csharp -Language CSharp
```

欠点は、インテリセンスが効かない。  
一度、名前空間に登録されたドメインは 2 回目の実行時に再登録できずエラーになる（開発時に try&error するのに不向き)
一応、名前空間に乱数を取り入れることで何度も実行可能にする手段もあるが、それはそれで気持ち悪い。
[参考]  
https://stackoverflow.com/questions/25730978/powershell-add-type-cannot-add-type-already-exist

## ■ cs ファイルを powershell で読み込んで実行する

cs ファイルを Get-Content で読み込む。

- cs ファイル

```cs
using System;
namespace HelloWorld
{
    public class Program
    {
        public static void Main()
    	{
        	Console.WriteLine("Hello world again!");
    	}
    }
}
```

- ps1 ファイル

```ps
$csharp = Get-Content -Path ./sample.cs -Raw
Add-Type -TypeDefinition $csharp -Language CSharp
Invoke-Expression "[HelloWorld.Program]::Main()"
```

こっちの方がインテリセンスが使えて良いような気もするけど、ドメインの重複登録不可な点は一緒。  
視認性が落ちないのであれば、1 ファイルで記載した方が可搬性含めて良い気がするけどどうだろう。
今のところ、敢えて cs ファイルで記載する必要性は感じていない。
