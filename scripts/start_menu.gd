extends CanvasLayer
var save_path : String = "user://persistent_data.json" 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not FileAccess.file_exists(save_path):
		get_node("Panel/VBoxContainer/LoadGameButton").disabled = true
	else: 
		get_node("Panel/VBoxContainer/LoadGameButton").disabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_load_game_button_pressed() -> void:
	LevelManager.load_game(false)
	LevelManager.close_start_menu()

func _on_new_game_button_pressed() -> void:
	LevelManager.load_game(true)
	LevelManager.close_start_menu()
