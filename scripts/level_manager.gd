extends Node2D

# this is a folder that you can find on the machine itself, not in the project.
# windows 
# %APPDATA%\Godot\app_userdata\[project_name]
# mac
# ~/Library/Application Support/Godot/app_userdata/[project_name]
# doc: https://docs.godotengine.org/en/stable/tutorials/io/data_paths.html
var save_path : String = "user://persistent_data.json" 

var current_scene: Node2D = null
var is_saved: bool = false
var menu_instance : CanvasLayer
var menu_scene : PackedScene

func _ready() -> void:
	current_scene = get_tree().current_scene
	menu_scene = load("res://scenes/main_menu.tscn")
	call_deferred("load_game") 
	# the call is deferred because in the Persistent node the group "Persistent" is added on _ready, so this singleton won't see it at moment (_ready of autoload cast before the others _ready)

func toggle_menu() -> void:
	if menu_instance:
		menu_instance.queue_free()
		menu_instance = null
	else:
		menu_instance = menu_scene.instantiate()
		get_tree().current_scene.add_child(menu_instance)

func change_scene(scene_path: String, spawn_type: String) -> void:
	if current_scene:
		current_scene.queue_free()  # Free the old scene before switching
	await get_tree().process_frame  # Ensure the old scene is freed before loading the new one
	var new_scene: Node2D = load(scene_path).instantiate()
	var spawn_point: Node = new_scene.get_node(spawn_type)
	var spawn_position: Vector2 = spawn_point.global_position
	get_tree().current_scene = new_scene
	get_tree().root.add_child(new_scene)
	current_scene = new_scene
	var player : CharacterBody2D = current_scene.get_node("Player")
	player.global_position = spawn_position

# Saving Logic 
var persistent_data: Dictionary = {}

# Initialize the file on the first load with default values
func initialize_persistent_dictionary() -> void:
	persistent_data.clear()
	for persistent in get_tree().get_nodes_in_group("Persistent"):
		if persistent.has_node("Persistent"):
			var id : String = persistent.get_node("Persistent").unique_id
			persistent_data[id] = {
				"position": {"x": persistent.global_position.x, "y": persistent.global_position.y},
				"is_interacted": false
			}
	var file : FileAccess = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_string(JSON.stringify(persistent_data, "\t"))
	file.close()

# override the saved data of each Persistent object
func save_game() -> void:
	for persistent in get_tree().get_nodes_in_group("Persistent"):
		if persistent.has_node("Persistent"):
			var id : String = persistent.get_node("Persistent").unique_id
			persistent_data[id] = {
				"position": {"x": persistent.global_position.x, "y": persistent.global_position.y},
				"is_interacted": persistent.get_node("Persistent").is_interacted
			}
	
	var file : FileAccess = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_string(JSON.stringify(persistent_data, "\t"))
	file.close()
	is_saved = true

# load the saved data (at the start of the game -> _ready)
func load_game() -> void:
	if not FileAccess.file_exists(save_path):
		print("No save file found, initializing fresh data.")
		initialize_persistent_dictionary()
		return
	
	var file : FileAccess = FileAccess.open(save_path, FileAccess.READ)
	persistent_data = JSON.parse_string(file.get_as_text())
	file.close()
		
	for persistent in get_tree().get_nodes_in_group("Persistent"):
		if persistent.has_node("Persistent"):
			var id : String = persistent.get_node("Persistent").unique_id
			if id in persistent_data:
				persistent.global_position.x = persistent_data[id]["position"].x
				persistent.global_position.y = persistent_data[id]["position"].y
				persistent.get_node("Persistent").is_interacted = bool(persistent_data[id]["is_interacted"])
