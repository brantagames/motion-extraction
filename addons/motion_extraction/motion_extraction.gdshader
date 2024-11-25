shader_type canvas_item;

void fragment() {
	COLOR = vec4(1.0 - texture(TEXTURE, UV).rgb, 0.5);
}
