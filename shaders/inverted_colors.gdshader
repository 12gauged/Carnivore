shader_type canvas_item;


uniform bool active = false;


void fragment() {
	vec4 final_color = texture(SCREEN_TEXTURE, SCREEN_UV);
	if (active) {
		final_color = vec4(1.0 - final_color.rgb, final_color.a);
	}
	COLOR = final_color;
}