extends Node

class_name RoomLoaderClass

@export var APARTMENT_SCENE: PackedScene
@export var HALLWAY_SCENE: PackedScene
@export var KITCHEN_SCENE: PackedScene
@export var JOB_SCENE: PackedScene
@export var GAME_END_SCENE: PackedScene

func load_room(room_id: int, spawn_string: String) -> void:
	var scene_to_load: PackedScene = room_id_to_scene(room_id)
	if scene_to_load == null:
		return
	LevelManager.change_scene(scene_to_load.resource_path, spawn_string)

func room_id_to_scene(room_id: int) -> PackedScene:
	match room_id:
		Room.ROOM_ID.BEDROOM:
			return APARTMENT_SCENE
		Room.ROOM_ID.HALLWAY:
			return HALLWAY_SCENE
		Room.ROOM_ID.KITCHEN:
			return KITCHEN_SCENE
		Room.ROOM_ID.JOB:
			return JOB_SCENE
		Room.ROOM_ID.GAME_END:
			return GAME_END_SCENE
		_: 
			# defaults to apartment BAD CASE
			return APARTMENT_SCENE
