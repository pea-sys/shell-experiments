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