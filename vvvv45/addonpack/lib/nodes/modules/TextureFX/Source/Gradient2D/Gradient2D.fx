texture ColorTexture;

float2 R;
float4 ColorA:COLOR;
float4 ColorB:COLOR;
float4 ColorC:COLOR;
float4 ColorD:COLOR;

float4x4 GradientTransform:TEXTUREMATRIX;
sampler s0=sampler_state{Texture=(ColorTexture);MipFilter=LINEAR;MinFilter=LINEAR;MagFilter=LINEAR;};
float4 psDir(float2 pos:TEXCOORD0):color{
    return tex2D(s0,pos);
}

void vs2d(inout float4 vp:POSITION0,inout float2 uv:TEXCOORD0){vp.xy*=2;uv+=.5/R;}
technique Gradient{pass pp0{vertexshader=compile vs_3_0 vs2d();pixelshader=compile ps_3_0 psDir();}}