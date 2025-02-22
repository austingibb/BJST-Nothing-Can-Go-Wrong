shader_type canvas_item;

#define PI 3.14159265
#define T TIME * 0.005

mat2 Rot(float a) {
    float s = sin(a);
	float c = cos(a);
    return mat2(vec2(c, -s), vec2(s, c));
}

//ALIEN ORB TYPE SHIT - ART OF CODE

float GyroScope(vec3 p) {
    p *= 10.;
    return abs(.7 * dot(sin(vec3(p.xy * Rot(-sin(T) * PI), p.z)), cos(vec3(p.yx * Rot(sin(T) * PI), p.z)))) -.03;
}

float GoobyGop(vec2 uv) {
    float g = GyroScope(uv.xyy + cos(T));
    g = mix (min(g, GyroScope(uv.yyx - sin(T))), max(g, GyroScope(uv.yyx - sin(T))), 0.5) * 1.1;
    return dot(g , g );
}

void fragment() {
	vec2 uv = UV;
	uv.x += GoobyGop(uv/10.0);
	uv.y -= GoobyGop(uv/10.0);
	uv = fract(uv);
	vec4 text = texture(TEXTURE, uv);

	COLOR = text;
}