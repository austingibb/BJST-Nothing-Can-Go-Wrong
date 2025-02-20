extends Node2D

@export var destination: PackedScene

func _on_interactable_component_interacted() -> void:
	print("Interacted")
	if destination:
		LevelManager.change_scene(destination.get_path())
