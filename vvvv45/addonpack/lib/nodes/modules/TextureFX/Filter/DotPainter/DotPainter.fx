float2 R;
float Amount; //Watch out, this is the square route of the amount of circles
float minSize = 0.0;
float maxSize = 10;
float smallDots<float uimin = 0;> = 1.0;

bool AntiAlias=0;
float Seed;
texture tex0;
sampler s0=sampler_state{Texture=(tex0);MipFilter=LINEAR;MinFilter=LINEAR;MagFilter=LINEAR;};
sampler s1=sampler_state{Texture=(tex0);MipFilter=POINT;MinFilter=POINT;MagFilter=POINT;};

// random function from 
// https://gamedev.stackexchange.com/questions/32681/random-number-hlsl
float rand_1_05(in float2 uv)
{
	// returns a random value between 0 and 1
    float2 noise = (frac(sin(dot(uv ,float2(12.9898,78.233)*2.0)) * 43758.5453));
    return abs(noise.x + noise.y) * 0.5;
}

float4 p0(float2 vp:vpos,float2 uv:TEXCOORD0,float4 vc:COLOR0):color{float2 x=(vp+.5)/R;
	float4 c=tex2D(s0,vc.xy);

	float cr=length(uv-.5);
	c.a=smoothstep(.50001,.5-AntiAlias*fwidth(cr),cr)*c.a*saturate(vc.a);	
    return c;
}

void v0(inout float4 vp:POSITION0,inout float2 uv:TEXCOORD0, out float ps:PSIZE, out float4 vc:COLOR0)
{	
	float2 p=vp.xy;
	//vp.xy=vp.xy/128.;
	vp.xy=vp.xy/Amount+float2((vp.y%2),0)/Amount*0.5;
	float ln=saturate(1-(p.y+p.x/Amount)/Amount);
	
	//ln=1-frac(ln*2.1);
	vc=tex2Dlod(s0,float4(vp.xy*.5+.5,0,0));
	uv+=.5/R;
	for (float i=0;i<4;i++)
	{
		float2 sz=pow(2,i*5+3);
		vp.xy+=sin((vp.yx)*sz+i*8+ln*2+Seed/sz)*58/(sz);
	}
	vp.xy=(frac(vp.xy)*2-1);
	vc=tex2Dlod(s0,float4(vp.xy*.5+.5,0,0));
	vc.xy=vp.xy*.5+.5;
	
	ps = abs( pow(rand_1_05(vp.xy), smallDots) * maxSize + minSize);

	vc.a=(ps);
	//if(vc.a<.9)ps=0;
	vp.y*=-1;
}
technique DotPainter{pass pp0{FillMode=Point;PointSpriteEnable=TRUE;AlphaBlendEnable=TRUE;SrcBlend=SRCALPHA;DestBlend=INVSRCALPHA;vertexshader=compile vs_3_0 v0();pixelshader=compile ps_3_0 p0();}}

