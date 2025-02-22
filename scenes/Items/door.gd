extends Node2D

@export var destination_scene: PackedScene
@export var destination_spawn_point: String

func _on_interactable_component_interacted() -> void:
	print("Interacted")
	if destination_scene:
		LevelManager.change_scene(destination_scene.get_path(), destination_spawn_point)
