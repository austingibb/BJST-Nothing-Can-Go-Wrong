class_name ControllerComponent
extends Node

@export var state_machine: Node
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	print(owner)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input_direction: Vector2 = Input.get_vector("left", "right", "forward", "backward")
	if (input_direction.x >= 0):
		get_parent().get_node("Sprite2D").scale.x = 1 
	else:
		get_parent().get_node("Sprite2D").scale.x = -1
	owner.velocity = input_direction.normalized() * 400
	owner.move_and_slide()
