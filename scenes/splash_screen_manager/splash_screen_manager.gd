extends Control

@export var in_time: float = 0.5
@export var fade_in_time: float = 1.5
@export var paused_time: float = 1.5
@export var fade_out_time: float = 1.5
@export var out_time: float = 0.5

@export var splash_screen_container: Control

var splash_screens: Array[Control]

func _ready() -> void:
	get_splash_screens()
	fade()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_pressed():
		self.queue_free()
		Global.scene_manager.change_gui_scene(
			GlobalEnums.SceneName.MainMenu,
			true,
			false,
			false,
		)

func get_splash_screens() -> void:
	for screen in splash_screen_container.get_children():
		screen.modulate.a = 0.0
		splash_screens.append(screen)

func fade() -> void:
	for screen in splash_screens:
		var tween: Tween = self.create_tween()
		tween.tween_interval(in_time)
		tween.tween_property(screen, "modulate:a", 1.0, fade_in_time)
		tween.tween_interval(paused_time)
		tween.tween_property(screen, "modulate:a", 0.0, fade_out_time)
		tween.tween_interval(out_time)
		await tween.finished
	Global.scene_manager.change_gui_scene(GlobalEnums.SceneName.MainMenu)
