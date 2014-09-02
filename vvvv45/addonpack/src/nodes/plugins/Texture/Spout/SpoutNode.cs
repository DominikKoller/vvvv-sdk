using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using VVVV.PluginInterfaces.V2;

namespace VVVV.Nodes.Texture
{
    [PluginInfo(Name = "Spout", Category = "EX9.Texture")]
    public class SpoutNode : IPluginEvaluate
    {
        static SpoutNode()
        {
            var platform = IntPtr.Size == 4 ? "x86" : "x64";
            var pathToThisAssembly = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
            var pathToBinFolder = Path.Combine(pathToThisAssembly, "Dependencies", platform);
            var envPath = Environment.GetEnvironmentVariable("PATH");
            envPath = string.Format("{0};{1}", envPath, pathToBinFolder);
            Environment.SetEnvironmentVariable("PATH", envPath);
        }

        #region pins

        [Input("Sender Index")]
        ISpread<int> FPinSenderIndexIn;

        [Output("Handle")]
        ISpread<long> FPinHandleOut;

        [Output("Width")]
        ISpread<uint> FPinWidthOut;

        [Output("Height")]
        ISpread<uint> FPinHeightOut;

        [Output("Texture Share Support")]
        ISpread<bool> FPinBTextureShareOut;

        [Output("Senders running")]
        ISpread<int> FPinSenderCountOut;

        #endregion pins

        public void Evaluate(int spreadMax)
        {
            //bool textureShare;
            //Spout.InitSender("Foo", 100, 100, out textureShare, true);

            uint width, height;
            bool bTextureShare;
            IntPtr dxShareHandle;
            string senderName;
            
                
            //Spout.InitReceiver(FPinSenderNameIn[0], out width, out height, out bTextureShare, false);

            FPinSenderCountOut[0] = Spout.GetSenderCount();

            var senderIndex = FPinSenderIndexIn[0];

            if (FPinSenderCountOut[0] > 0)
                senderIndex = FPinSenderIndexIn[0] % FPinSenderCountOut[0];

            Spout.GetSenderNameInfo(senderIndex, out senderName, 512, out width, out height, out dxShareHandle);
            
            FPinWidthOut[0] = width;
            FPinHeightOut[0] = height;
            FPinHandleOut[0] = dxShareHandle.ToInt64();
            FPinBTextureShareOut[0] = Spout.TextureShareCompatible();
        }
    }
}
