$id = get-random
$csharp = @"
using System;
namespace HelloWorld
{
    public class Program$id
    {
        public static void Main(){
            Console.WriteLine("Hello world again!");
        }
    }
}
"@

Add-Type -TypeDefinition $csharp -Language CSharp 
Invoke-Expression "[HelloWorld.Program$id]::Main()"