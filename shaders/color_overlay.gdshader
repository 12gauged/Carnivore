shader_type canvas_item;

uniform vec4 overlay_color: hint_color = vec4(0.25, 0.25, 0.25, 1.0);

void fragment() {
	vec4 BLACK = vec4(0.0, 0.0, 0.0, 1.0);
	vec4 pixel_color = texture(SCREEN_TEXTURE, SCREEN_UV);
	vec4 final_color;
	
	if (pixel_color == vec4(1.0, 1.0, 1.0, 1.0)) {
		final_color = overlay_color;
	} else {
		final_color = pixel_color;
	}
	COLOR = final_color;
}