shader_type canvas_item;

uniform vec4 colors_to_replace[10] : source_color;
uniform vec4 replacement_colors[10] : source_color;
uniform bool enabled;

void vertex() {
	// Called for every vertex the material is visible on.
}

vec4 apply_color_replace(vec4 c, vec4 color_to_replace, vec4 replacement_color) {
	if(distance(c, color_to_replace) < 0.1) {
		return replacement_color;
	}
	return c;
}

void fragment() {
	if(!enabled) {
		for(int i = 0; i < 10; i++) {
			COLOR = apply_color_replace(COLOR, colors_to_replace[i], replacement_colors[i]);
		}
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}