extends Node2D

@export var destination_room: GlobalEnums.SceneName
@export var destination_spawn_point: String

func _on_interactable_component_interacted() -> void:
	print("Interacted with door, attempting to load room:", destination_room)
	Global.scene_manager.load_room(destination_room, destination_spawn_point)
