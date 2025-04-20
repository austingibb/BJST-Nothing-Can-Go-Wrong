extends Node2D
@export var on_screen : Sprite2D  
func _ready() -> void:
	_set_screen_to_debug()

func _on_interactable_component_interacted() -> void:
	Global.debug_log = not Global.debug_log
	if Global.debug_log:
		print("debug logging enabled")
	else:
		print("debug logging disabled")
	_set_screen_to_debug()

func _set_screen_to_debug() -> void:
	if is_instance_valid(on_screen):
		on_screen.visible = Global.debug_log
