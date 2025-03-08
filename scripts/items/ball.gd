extends Node2D

class_name BjstBall

var shader_material : ShaderMaterial = null
var enable_ball_color_replacement : bool = false

func _ready() -> void:
	var ball_sprite2d : Sprite2D = get_node("Sprite2D") as Sprite2D
	shader_material = ball_sprite2d.material as ShaderMaterial

func _on_interactable_component_interacted() -> void:
	if Dialogic.current_timeline == null:
		Dialogic.start("ball")

func toggle_color() -> void:
	enable_ball_color_replacement = !enable_ball_color_replacement
	shader_material.set_shader_parameter("enabled", enable_ball_color_replacement)
