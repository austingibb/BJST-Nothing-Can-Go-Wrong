extends Node2D

const SAVE_FILE_PATH := "user://savegame.json"

var current_scene: Node2D = null
var is_saved: bool = false
var menu_instance : CanvasLayer
var menu_scene : PackedScene

func _ready() -> void:
	current_scene = get_tree().current_scene
	menu_scene = load("res://scenes/main_menu.tscn")

func toggle_menu() -> void:
	if menu_instance:
		menu_instance.queue_free()
		menu_instance = null
	else:
		menu_instance = menu_scene.instantiate()
		get_tree().current_scene.add_child(menu_instance)

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
