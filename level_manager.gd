extends Node2D

const SAVE_FILE_PATH := "user://savegame.json"

var current_scene: Node2D = null
var is_saved: bool = false

func _ready() -> void:
	current_scene = get_tree().current_scene

func change_scene(scene_path: String) -> void:
	if current_scene:
		current_scene.call_deferred("queue_free")

	var new_scene: Node2D = load(scene_path).instantiate() 
	get_tree().current_scene = new_scene
	get_tree().root.add_child(new_scene)
	current_scene = new_scene

func save_game() -> void:
	is_saved = true
	print("Game Saved!")
