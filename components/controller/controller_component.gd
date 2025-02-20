class_name ControllerComponent
extends Node

@export var state_machine: Node
@export var speed: float

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Handle player movement
	var input_direction: Vector2 = Input.get_vector("left", "right", "forward", "backward")

	if (input_direction.x >= 0):
		get_parent().get_node("Sprite2D").flip_h = true 
	else:
		get_parent().get_node("Sprite2D").flip_h = false
	owner.velocity = input_direction.normalized() * speed
	owner.move_and_slide()

# this is the relevant code for handling opening the next level proof of concept
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("change_level"):
		_open_next_level()

# this is the relevant code for handling opening the next level proof of concept
func _open_next_level() -> void:
	LevelManager.change_scene("res://scenes/factory_mini_game.tscn")
