//
//					Spout.h - Version 1.01
// 
/*
#ifndef __ofxSpout__
#define __ofxSpout__

#include <windows.h>
#include <gl/GL.h>
#include <set>
#include <string>
*/

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.InteropServices;

namespace VVVV.Nodes.Texture
{

    public static class Spout
    {
        // exported functions

        // -----------------------------
        // Creation and deletion
        // -----------------------------
        /*
        extern "C" _declspec(dllexport)
        bool InitSender(char *name, unsigned int width, unsigned int height, bool& bTextureShare, bool bMemoryShare = false);
        */
        [DllImport("Spout.dll")]
        public static extern bool InitSender(
            [MarshalAs(UnmanagedType.LPStr)] string name,
            uint width,
            uint height,
            out bool bTextureShare,
            bool bMemoryShare);

        /*
        extern "C" _declspec(dllexport)
        bool InitReceiver (char *name, unsigned int& width, unsigned int& height, bool& bTextureShare, bool bMemoryShare = false);
        */
        [DllImport("Spout.dll")]
        public static extern bool InitReceiver(
        [MarshalAs(UnmanagedType.LPStr)] string name,
            out uint width,
            out uint height,
            out bool bTextureShare,
            bool bMemoryShare);

        /*
        extern "C" _declspec(dllexport)
        bool ReleaseSender();
        */
        [DllImport("Spout.dll")]
        public static extern bool ReleaseSender();

        /*
        extern "C" _declspec(dllexport)
        bool ReleaseReceiver(); 
        */
        [DllImport("Spout.dll")]
        public static extern bool ReleaseReceiver();
        /*
        extern "C" _declspec(dllexport)
        bool CloseSpout(); 
        */
        [DllImport("Spout.dll")]
        public static extern bool CloseSpout();
        // -----------------------------


        // -----------------------------
        // Sending and receiving opengl textures
        // -----------------------------
        /*
        extern "C" _declspec(dllexport)
        bool SendTexture(GLuint TextureID, GLuint TextureTarget, unsigned int width, unsigned int height, bool bInvert = false);
        */
        /*
        extern "C" _declspec(dllexport)
        bool ReceiveTexture(char *name, GLuint TextureID, GLuint TextureTarget, unsigned int &width, unsigned int &height);
        */


        // -----------------------------
        // User interface
        // -----------------------------
        /*
        extern "C" _declspec(dllexport)
        bool SelectSenderDialog();
         */
        /*
        extern "C" _declspec(dllexport)
        bool SelectSenderPanel();
        */
        // -----------------------------


        // -----------------------------
        // Sender management
        // -----------------------------
        /*
        extern "C" _declspec(dllexport)
        bool GetSenderNames(std::set<std::string> *sendernames);
        */
        /*
        extern "C" _declspec(dllexport)
        int GetSenderCount();
        */
        [DllImport("Spout.dll")]
        public static extern int GetSenderCount();
        /*
        extern "C" _declspec(dllexport)
        bool GetSenderNameInfo(int index, char* sendername, int sendernameMaxSize, unsigned int &width, unsigned int &height, HANDLE &dxShareHandle);
        */
        [DllImport("Spout.dll")]
        public static extern bool GetSenderNameInfo(
            int index,
        [MarshalAs(UnmanagedType.LPStr)] out string name,
            int sendernameMaxSize,
            out uint width,
            out uint height,
            out IntPtr dxShareHandle);
        /*
        extern "C" _declspec(dllexport)
        bool GetSenderNameMap(char *sendermap);
        */
        /*
        extern "C" _declspec(dllexport)
        bool GetSenderInfo(char* sendername, unsigned int &width, unsigned int &height, HANDLE &dxShareHandle);
        */
        [DllImport("Spout.dll")]
        public static extern bool GetSenderInfo(
        [MarshalAs(UnmanagedType.LPStr)] string name,
            out uint width,
            out uint height,
            out IntPtr dxShareHandle);
        // -----------------------------


        // -----------------------------
        // Utilities
        // -----------------------------
        /*
        extern "C" _declspec(dllexport)
        bool TextureShareCompatible();
        */
        [DllImport("Spout.dll")]
        public static extern bool TextureShareCompatible();

        /*
        extern "C" _declspec(dllexport)
        void SpoutDebugConsole();
        */
        // -----------------------------
    }

}

/*
#endif
*/