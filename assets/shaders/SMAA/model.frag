#version 420

in defaultBlock
{
	vec4 		position;
	vec2		uv;
} inBlock;

out vec4 outColor;

layout(std140, binding = 0) uniform defaultSettings
{
	mat4		projection;
	mat4 		view;
	mat4 		translation;
	vec2		resolution;
	vec2		mousePosition;
	float		deltaTime;
	float		totalTime;
	float 		framesPerSecond;
	uint 		totalFrames;
};

/*layout(std140, binding = 1) uniform materialSettings
{
	vec4 		diffuseMat;
	vec4		specularMat;
	vec4		ambientMat;
	vec4		emissiveMat;
};*/

void main()
{
	outColor = vec4(1, 0, 0, 1);
}