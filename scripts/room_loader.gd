extends Node

class_name RoomLoaderClass

@export var APARTMENT_SCENE: PackedScene
@export var HALLWAY_SCENE: PackedScene
@export var JOB_SCENE: PackedScene

func load_room(room_id: int) -> void:
	var result: Array = room_id_to_scene(room_id)
	var scene_to_load: PackedScene = result[0]
	var spawn_string: String = result[1]

	if scene_to_load == null:
		return
	
	LevelManager.change_scene(scene_to_load.resource_path, spawn_string)

func room_id_to_scene(room_id: int) -> Array:
	match room_id:
		Room.ROOM_ID.BEDROOM:
			return [APARTMENT_SCENE, "SpawnHallwayDoor"]
		Room.ROOM_ID.HALLWAY:
			return [HALLWAY_SCENE, "SpawnApartmentDoor"]
		Room.ROOM_ID.JOB:
			return [JOB_SCENE, "N/A"]
		_:
			return []

			
