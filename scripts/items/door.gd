extends Node2D

@export var destination_room: int
@export var destination_spawn_point: String

func _on_interactable_component_interacted() -> void:
	print("Interacted with door, attempting to load room:", destination_room)
	RoomLoader.load_room(destination_room, destination_spawn_point)
