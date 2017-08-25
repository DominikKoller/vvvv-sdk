float2 R;
float4 Frequency = float4(1.0,1.0,1.0,1.0);
float4 Phase = float4(0.0,0.0,0.0,0.0);
bool Grayscale;
bool Alpha;
static const float PI = 3.14159265f;

texture tex0;
sampler s0=sampler_state{Texture=(tex0);MipFilter=LINEAR;MinFilter=LINEAR;MagFilter=LINEAR;};
float4 texIN(sampler s,float2 x){
    float4 c=tex2D(s,x);
    if(Grayscale)c.rgb=dot(c.rgb,normalize(float3(.33,.59,.11))/1.5);
    return c;
}

float4 moduloOne(float4 input)
{
	if(input.r!=1.0)
		input.r%=1.0;
	if(input.g!=1.0)
		input.g%=1.0;
	if(input.b!=1.0)
		input.b%=1.0;
	if(input.a!=1.0)
		input.a%=1.0;
	
	return input;
}

float4 pLIN(float2 x:TEXCOORD0):color{
    float4 c=texIN(s0,x); float pa = c.a;
    c=(c+Phase)*Frequency;
	c = moduloOne(c);
	if(!Alpha)c.a=pa;
    return c;
}
float4 pINV(float2 x:TEXCOORD0):color{
    float4 c=texIN(s0,x);float pa=c.a;
    c=(c+Phase)*Frequency;
	c = 1.0 - moduloOne(c);
    if(!Alpha)c.a=pa;
    return c;
}
float4 pTRI(float2 x:TEXCOORD0):color{
    float4 c=texIN(s0,x);float pa=c.a;
    c=1-2*abs(frac((c+Phase)*Frequency)-.5);
    if(!Alpha)c.a=pa;
    return c;
}
float4 pSIN(float2 x:TEXCOORD0):color{
    float4 c=texIN(s0,x);float pa=c.a;
	c = (c+Phase)*Frequency;
	c = 0.5+0.5*cos(c*PI*2); // analogos to WaveShaper, and between 0 and 1
    if(!Alpha)c.a=pa;
    return c;
}
float4 pREC(float2 x:TEXCOORD0):color{
    float4 c=texIN(s0,x);float pa=c.a;
	
	c = (c+Phase)*Frequency;
	c = moduloOne(c); //this is NOT the same as frac(c), since it checks for 1.0
    c=step(0.5-c,0); // Is c greater than 0.5?
    if(!Alpha)c.a=pa;
    return c;
}

void vs2d(inout float4 vp:POSITION0,inout float2 uv:TEXCOORD0){vp.xy*=2;uv+=.5/R;}
technique Linear{pass pp0{vertexshader=compile vs_2_0 vs2d();pixelshader=compile ps_2_0 pLIN();}}
technique Inverse{pass pp0{vertexshader=compile vs_2_0 vs2d();pixelshader=compile ps_2_0 pINV();}}
technique Triangle{pass pp0{vertexshader=compile vs_2_0 vs2d();pixelshader=compile ps_2_0 pTRI();}}
technique Sine{pass pp0{vertexshader=compile vs_2_0 vs2d();pixelshader=compile ps_2_0 pSIN();}}
technique Rectangle{pass pp0{vertexshader=compile vs_2_0 vs2d();pixelshader=compile ps_2_0 pREC();}}
