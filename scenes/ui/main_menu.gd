extends Control

func _ready() -> void:
	Global.music_manager.play(GlobalEnums.MusicName.MenuMusic)

# Menu
func _on_start_game_button_pressed() -> void:
	Global.scene_manager.change_2d_scene(GlobalEnums.SceneName.Apartment)
	self.queue_free()

func _on_settings_button_pressed() -> void:
	Global.scene_manager.change_gui_scene(
		GlobalEnums.SceneName.SettingsMenu,
		true,
		false,
		false
	)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
