float2 R;
float4 BorderCol:COLOR ={0.0,0.0,0.0,1.0};
float2 Cells <float uimin=0.0;> = (8.0,8.0);
bool Mir;
float Rotate;
float2 Scale;
texture tex0;
sampler s0=sampler_state{Texture=(tex0);MipFilter=None;MinFilter=LINEAR;MagFilter=LINEAR;};
float2 r2d(float2 x,float a){return float2(cos(a)*x.x+sin(a)*x.y,cos(a)*x.y-sin(a)*x.x);}
float4 p0(float2 x:TEXCOORD0):color{
    float2 dx=r2d(frac((x-.5)*Cells-.5)-.5,Rotate*acos(-1)*2)/Cells/Scale+.5;
    if(Mir)dx=r2d(abs(frac((x-.5)*Cells/2-.5)-.5),Rotate*acos(-1)*2)/Cells*2/Scale+.5;
    float4 c=tex2D(s0,dx);
    return c;
}
void vs2d(inout float4 vp:POSITION0,inout float2 uv:TEXCOORD0){vp.xy*=2;uv+=.5/R;}

technique Clamp{pass pp0{AddressU[0]=CLAMP;AddressV[0]=CLAMP;vertexshader=compile vs_2_0 vs2d();pixelshader=compile ps_2_0 p0();}}
technique Wrap{pass pp0{AddressU[0]=WRAP;AddressV[0]=WRAP;vertexshader=compile vs_2_0 vs2d();pixelshader=compile ps_2_0 p0();}}
technique Mirror{pass pp0{AddressU[0]=MIRROR;AddressV[0]=MIRROR;vertexshader=compile vs_2_0 vs2d();pixelshader=compile ps_2_0 p0();}}
technique Border{pass pp0{AddressU[0]=BORDER;AddressV[0]=BORDER;BorderColor[0]=BorderCol;vertexshader=compile vs_2_0 vs2d();pixelshader=compile ps_2_0 p0();}}

