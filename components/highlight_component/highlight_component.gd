class_name HighlightComponent
extends Node

@export var sprite: Sprite2D
@export var shader_material: ShaderMaterial

func highlight(enabled: bool) -> void:
	print(self.get_path())
	var owner: Node2D = self.get_parent()
	print(owner.get_path())

	if sprite:
		if enabled:
			sprite.material = shader_material
		else:
			sprite.material = null
	elif shader_material:
		if owner.has_node("Sprite2D"):
			print("Has Sprite2D")
			var sprite_node: Sprite2D = owner.get_node("Sprite2D")
			if enabled:
				print("Attaching shader material")
				sprite_node.material = shader_material
			else:
				print("Removing shader material")
				sprite_node.material = null
		else:
			print("No Sprite2D node found!")

	else:
		push_warning("No shader material assigned!")
