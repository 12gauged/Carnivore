shader_type canvas_item;


uniform bool flashing = false;


void fragment() {
	vec4 pixel_color = texture(TEXTURE, UV);
	
	if(flashing && pixel_color != vec4(0.0)) {
		pixel_color.a = sin(TIME * 40.0);
	}
	
	COLOR = pixel_color;
}
