extends Node

# this is the relevant code for handling opening the next level proof of concept
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_menu"):  # Default "ESC" action in Godot
		print("HERE")
		toggle_menu()

func toggle_menu() -> void:
	LevelManager.toggle_menu()
