extends Node2D

@export var destination_room: int
@export var destination_spawn_point: String

# demo sequence
var sequence: Array[GlobalConstants.FactoryObject] = [
	GlobalConstants.FactoryObject.BirdHouse,
	GlobalConstants.FactoryObject.BirdHouse,
	GlobalConstants.FactoryObject.BirdHouse,
	GlobalConstants.FactoryObject.BirdHouse,
	GlobalConstants.FactoryObject.Space,
	GlobalConstants.FactoryObject.BirdHouse,
	GlobalConstants.FactoryObject.Space,
	GlobalConstants.FactoryObject.BirdHouse,
	GlobalConstants.FactoryObject.Space,
	GlobalConstants.FactoryObject.BirdHouse,
]
var object_count: int

signal spawn_start(sequence: Array[GlobalConstants.FactoryObject])

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.music_manager.play(GlobalEnums.MusicName.Factory)
	object_count = sequence.count(GlobalConstants.FactoryObject.BirdHouse)
	spawn_start.emit(sequence)

func _on_kill_box_factory_object_killed() -> void:
	object_count -= 1
	if object_count == 0:
		#StoryManager.day_num += 1
		Global.scene_manager.load_room(GlobalEnums.SceneName.Apartment, destination_spawn_point)
