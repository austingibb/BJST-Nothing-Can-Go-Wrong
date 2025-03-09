extends Node

# abstract class
class_name ControllerComponent

@export var speed: float = 300

# managed by controller orchestrator
var _is_active_controller: bool = false

func _get_input_dir() -> Vector2:
	var input_direction: Vector2 = Input.get_vector("left", "right", "forward", "backward")
	return input_direction

func _apply_velocity(input_dir: Vector2) -> void:
	if not owner is CharacterBody2D:
		return

	var char_body_2D : CharacterBody2D = owner as CharacterBody2D
	char_body_2D.velocity = input_dir * speed
	char_body_2D.move_and_slide()

func activate() -> void:
	_is_active_controller = true

func deactivate() -> void:
	_is_active_controller = false
