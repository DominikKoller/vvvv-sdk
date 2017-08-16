float2 res;
int asciiCount = 176; // Count of ASCII characters, horizontally in the texture
float2 tileSize = float2(8,12); // Pixel resolution of resulting tiles
bool color = false;

texture tex0;
sampler s0=sampler_state{Texture=(tex0);MipFilter=None;MinFilter=POINT;MagFilter=POINT;};
texture tex1;
sampler s1=sampler_state{Texture=(tex1);MipFilter=None;MinFilter=Point;MagFilter=Point;};
float mx(float3 p){return max(p.x,max(p.y,p.z));}
float4 p0(float2 pos:TEXCOORD0):color{
    //float2 currentPixel=x*resolution-.25;
	
	//float2 currentTile = floor(currentPixel/tileSize) * asciiResolution/resolution+0.5/resolution;
	
	//float2 tileIndex = floor(pos*res / tileSize); // +0.5 as we will sample in the middle of the tile
	
	//float4 c = tex2D(s0, tileIndex/tileSize*res);
	
	float2 tilecount = res / tileSize;
	float2 newPos = (floor(pos * tilecount) + 0.5) / tilecount;

	float4 c = tex2D(s0, newPos);
	//float grey=mx(c.rgb);
	
    //grey=dot(c.rgb,1.)/3.;
    //grey=pow(grey,5.);
	
	float grey = 0.2126*c.r + 0.7152*c.g + 0.0722*c.b; //percieved luminance values of rgb
	grey = pow(grey, 4);
	
	float tileNumber = grey; //need to figure out by grey value
	float2 posInTile = frac(res*pos/tileSize);
	
	float letter = tex2D(s1, (float2(floor(tileNumber*asciiCount),0)+posInTile) / float2(176,1));
	
    //float4 c=tex2D(s0,floor(currentPixel/(sz*asciiScale))*(sz*asciiScale)/resolution+.5/resolution);
    //float grey=mx(c.rgb);
    //grey=dot(c.rgb,1.)/3.;
    //grey=pow(grey,5.);
	//float letter=tex2D(s1,(frac(vp/sz)+float2(grey*176,0))/float2(176,1));
    c.rgb=c.rgb*letter;
    if(color)
		return float4(c.rgb*letter, 1);
	return letter;
}
void vs2d(inout float4 vp:POSITION0,inout float2 uv:TEXCOORD0){
	
	vp.xy*=2;
	//uv+=.5/res;

}
technique Ascii{pass pp0{vertexshader=compile vs_3_0 vs2d();pixelshader=compile ps_3_0 p0();}}
