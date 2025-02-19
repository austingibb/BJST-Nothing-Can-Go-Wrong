class_name ControllerComponent
extends Node

@export var state_machine: Node
@export var speed: float

func _process(delta: float) -> void:
	# Handle player movement
	var input_direction: Vector2 = Input.get_vector("left", "right", "forward", "backward")
	if input_direction.x >= 0:
		get_parent().get_node("Sprite2D").scale.x = 1 
	if (input_direction.x >= 0):
		get_parent().get_node("Sprite2D").flip_h = true 
	else:
		get_parent().get_node("Sprite2D").flip_h = false
	owner.velocity = input_direction.normalized() * speed
	owner.move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("open_menu"):  # Default "ESC" action in Godot
		toggle_menu()
	if event.is_action_pressed("change_level"):
		_open_next_level()

func toggle_menu() -> void:
	if menu_instance:
		menu_instance.queue_free()
		menu_instance = null
	else:
		menu_instance = menu_scene.instantiate()
		get_tree().current_scene.add_child(menu_instance)
		
func _open_next_level() -> void:
	LevelManager.change_scene("res://scenes/factory_mini_game.tscn")
