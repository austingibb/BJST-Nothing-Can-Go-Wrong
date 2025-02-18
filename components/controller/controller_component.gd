extends Node
class_name ControllerComponent

@export var state_machine: Node
var menu_scene: PackedScene = preload("res://scenes/main_menu.tscn")  # Adjust path if needed
var menu_instance: CanvasLayer = null  # Store reference to the menu

func _ready() -> void:
	print(owner)

func _process(delta: float) -> void:
	# Handle player movement
	var input_direction: Vector2 = Input.get_vector("left", "right", "forward", "backward")
	if input_direction.x >= 0:
		get_parent().get_node("Sprite2D").scale.x = 1 
	else:
		get_parent().get_node("Sprite2D").scale.x = -1
	owner.velocity = input_direction.normalized() * 400
	owner.move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("open_menu"):  # Default "ESC" action in Godot
		toggle_menu()

func toggle_menu() -> void:
	if menu_instance:
		menu_instance.queue_free()
		menu_instance = null
	else:
		menu_instance = menu_scene.instantiate()
		get_tree().current_scene.add_child(menu_instance)
		
