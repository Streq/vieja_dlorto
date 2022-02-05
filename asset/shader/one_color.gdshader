shader_type canvas_item;

uniform vec4 color : hint_color = vec4(1.0, 1.0, 1.0, 1.0);

void fragment()
{
	vec4 pixel_color = texture(TEXTURE, UV);
	COLOR = color;
	COLOR.a = pixel_color.a;
}