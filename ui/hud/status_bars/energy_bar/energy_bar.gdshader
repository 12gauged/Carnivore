shader_type canvas_item;

uniform bool active = false;
uniform float direction = -1f;

void fragment() {
	
	vec4 final_color = texture(TEXTURE, UV);
	
	if(final_color.a > 0.0 && final_color != vec4(0.0, 0.0, 0.0, 1.0)) {
		float color_value = 1f;
		if (active) {
			color_value = max(0.8, 0.8 + sin(TIME * 20f));
		}
		final_color = vec4(color_value, color_value, color_value, 1.0);
	}
	
	COLOR = final_color;
}

void vertex() {
	if(active) {
		VERTEX.y += sin(TIME * 40f) * direction / 3f;
	}
}