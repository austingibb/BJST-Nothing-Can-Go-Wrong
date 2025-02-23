extends Node2D

@export var destination_scene: PackedScene
@export var destination_spawn_point: String

# demo sequence
var sequence: Array[GlobalEnums.FactoryObject] = [
	GlobalEnums.FactoryObject.BirdHouse,
	GlobalEnums.FactoryObject.BirdHouse,
	GlobalEnums.FactoryObject.BirdHouse,
	GlobalEnums.FactoryObject.BirdHouse,
	GlobalEnums.FactoryObject.Space,
	GlobalEnums.FactoryObject.BirdHouse,
	GlobalEnums.FactoryObject.Space,
	GlobalEnums.FactoryObject.BirdHouse,
	GlobalEnums.FactoryObject.Space,
	GlobalEnums.FactoryObject.BirdHouse,
]
var object_count: int

signal spawn_start(sequence: Array[GlobalEnums.FactoryObject])

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	object_count = sequence.count(GlobalEnums.FactoryObject.BirdHouse)
	spawn_start.emit(sequence)

func _on_kill_box_factory_object_killed() -> void:
	object_count -= 1
	if object_count == 0:
		if destination_scene:
			LevelManager.change_scene(destination_scene.get_path(), destination_spawn_point)
