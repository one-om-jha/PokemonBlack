shader_type canvas_item;

uniform vec2 Direction = vec2(-1.0,-1.0);
uniform float Speed = 0.015;

void fragment() {
	COLOR = texture(TEXTURE, UV + (vec2(-1.0,-1.0) * TIME * 0.15)) * 0.2;
}