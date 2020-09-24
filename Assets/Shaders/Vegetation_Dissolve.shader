// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Progress/Vegetation_Dissolve"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_Albedo("Albedo", 2D) = "white" {}
		_Normal("Normal", 2D) = "white" {}
		_NormalStrenght("Normal Strenght", Range( 0 , 1)) = 0
		_DisolveGuide("Disolve Guide", 2D) = "white" {}
		_DissolveAmount("Dissolve Amount", Range( 0 , 1)) = 0
		_Float0("Float 0", Range( 0 , 0.0008)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Transparent+0" }
		Cull Off
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
		#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
		#else//ASE Sampling Macros
		#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
		#endif//ASE Sampling Macros

		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _DissolveAmount;
		uniform float _Float0;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_Normal);
		uniform float4 _Normal_ST;
		SamplerState sampler_Normal;
		uniform float _NormalStrenght;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_Albedo);
		uniform float4 _Albedo_ST;
		SamplerState sampler_Albedo;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_DisolveGuide);
		SamplerState sampler_DisolveGuide;
		uniform float4 _DisolveGuide_ST;
		uniform float _Cutoff = 0.5;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float temp_output_24_0 = (-0.6 + (_DissolveAmount - 0.0) * (0.6 - -0.6) / (1.0 - 0.0));
			float3 ase_vertexNormal = v.normal.xyz;
			v.vertex.xyz += ( ( 1.0 - (0.0 + (temp_output_24_0 - -0.6) * (1.0 - 0.0) / (0.6 - -0.6)) ) * ( ase_vertexNormal * _Float0 ) );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			o.Normal = UnpackScaleNormal( SAMPLE_TEXTURE2D( _Normal, sampler_Normal, uv_Normal ), _NormalStrenght );
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			o.Albedo = SAMPLE_TEXTURE2D( _Albedo, sampler_Albedo, uv_Albedo ).rgb;
			o.Alpha = 1;
			float temp_output_24_0 = (-0.6 + (_DissolveAmount - 0.0) * (0.6 - -0.6) / (1.0 - 0.0));
			float2 uv_DisolveGuide = i.uv_texcoord * _DisolveGuide_ST.xy + _DisolveGuide_ST.zw;
			clip( ( temp_output_24_0 + SAMPLE_TEXTURE2D( _DisolveGuide, sampler_DisolveGuide, uv_DisolveGuide ).r ) - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18400
335;224;1679;933;1623.967;181.5311;1.479586;False;True
Node;AmplifyShaderEditor.RangedFloatNode;25;-1469.296,64.77869;Float;False;Property;_DissolveAmount;Dissolve Amount;5;0;Create;True;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;24;-1145.301,70.17361;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-0.6;False;4;FLOAT;0.6;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;30;-809.889,213.5986;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-0.6;False;2;FLOAT;0.6;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;26;-792.7355,441.8336;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;27;-892.7357,621.8333;Inherit;False;Property;_Float0;Float 0;6;0;Create;True;0;0;False;0;False;0;0;0;0.0008;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-660.792,-127.0858;Inherit;False;Property;_NormalStrenght;Normal Strenght;3;0;Create;True;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;22;-1220.362,250.3355;Inherit;True;Property;_DisolveGuide;Disolve Guide;4;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;31;-600.8885,299.5984;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-569.7354,487.8334;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;4;-356.3466,-116.3876;Inherit;True;Property;_Normal;Normal;2;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-364.4016,-346.2643;Inherit;True;Property;_Albedo;Albedo;1;0;Create;True;0;0;True;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;21;-890.4881,71.11585;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-422.8876,335.5986;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;2;-10.89999,-132.1;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Progress/Vegetation_Dissolve;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;True;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;24;0;25;0
WireConnection;30;0;24;0
WireConnection;31;0;30;0
WireConnection;28;0;26;0
WireConnection;28;1;27;0
WireConnection;4;5;32;0
WireConnection;21;0;24;0
WireConnection;21;1;22;1
WireConnection;29;0;31;0
WireConnection;29;1;28;0
WireConnection;2;0;3;0
WireConnection;2;1;4;0
WireConnection;2;10;21;0
WireConnection;2;11;29;0
ASEEND*/
//CHKSM=CEBF1927C5842B6F6FBCDD0B4B964E04782619AB