extends Control

@onready var sfx_player: AudioStreamPlayer = %SFXPlayer

# Sliders
@onready var master_slider: HSlider = %MasterSlider
@onready var music_slider: HSlider = %MusicSlider
@onready var sfx_slider: HSlider = %SFXSlider

@onready var MASTER_BUS_ID: int = AudioServer.get_bus_index("Master")
@onready var MUSIC_BUS_ID: int = AudioServer.get_bus_index("Music")
@onready var SFX_BUS_ID: int = AudioServer.get_bus_index("SFX")

func _ready() -> void:
	#sfx_player.stream = load("res://assets/audio/sfx/grow_sound.mp3")
	# sliders_init
	master_slider.value = Global.master_volume
	music_slider.value = Global.music_volume
	sfx_slider.value = Global.sfx_volume

# Settings
func _on_back_button_pressed() -> void:
	if Global.scene_manager.world2d.get_children().size() > 0:
		Global.scene_manager.change_gui_scene(
			GlobalEnums.SceneName.PauseMenu,
			true, 
			false,
			false
		)
	else:
		Global.scene_manager.change_gui_scene(
			GlobalEnums.SceneName.MainMenu,
			true, 
			false,
			false
		)

func _on_master_slider_value_changed(value: float) -> void:
	Global.master_volume = value
	AudioServer.set_bus_volume_linear(MASTER_BUS_ID, value)

func _on_music_slider_value_changed(value: float) -> void:
	Global.music_volume = value
	AudioServer.set_bus_volume_linear(MUSIC_BUS_ID, value)

func _on_sfx_slider_value_changed(value: float) -> void:
	Global.sfx_volume = value
	AudioServer.set_bus_volume_linear(SFX_BUS_ID, value)

func _on_sfx_slider_drag_ended(value_changed: bool) -> void:
	pass
	#sfx_player.play()
