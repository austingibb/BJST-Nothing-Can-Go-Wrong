class_name HighlightComponent
extends Node

@export var shader_material: ShaderMaterial

func highlight(enabled: bool) -> void:
	if shader_material:
		if owner.has_node("Sprite2D"):
			var sprite_node: Sprite2D = owner.get_node("Sprite2D")
			if enabled:
				sprite_node.material = shader_material
			else:
				sprite_node.material = null
	else:
		push_warning("No shader material assigned!")
