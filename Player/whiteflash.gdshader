shader_type canvas_item;

uniform vec4 color;
uniform float flashing = 0;

void fragment(){
	vec4 previousColor = texture(TEXTURE,UV);
	vec4 flashColor = vec4(color.r,color.g,color.b,color.a*previousColor.a);

	COLOR =  mix(previousColor, flashColor, flashing);
}