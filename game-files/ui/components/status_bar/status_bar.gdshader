shader_type canvas_item;


uniform int mode = 0;


void fragment() {
	vec4 pixel_color = texture(TEXTURE, UV);
	vec4 final_color = pixel_color;
	

	if (mode == 1) {
		float icon_size = TEXTURE_PIXEL_SIZE.x * 8.0;
		float operator = 1.0;
		
		if (
			UV.x > icon_size && UV.x < icon_size * 2.0 ||
			UV.x > icon_size * 3.0 && UV.x < icon_size * 4.0 ||
			UV.x > icon_size * 5.0 && UV.x < icon_size * 6.0
		) {
			operator = -1.0;
		}
		
		final_color = texture(TEXTURE, vec2(UV.x, UV.y + sin(TIME * 40.0) * 0.04 * operator));
	}


	COLOR *= final_color;
}
