extends Node
class_name ControllerComponent

@export var speed: float = 300
@export var packed_scene: PackedScene
@export var animation_handler: AnimationHandler

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Handle player movement
	if Dialogic.current_timeline == null:
		var input_direction: Vector2 = Input.get_vector("left", "right", "forward", "backward")
		if animation_handler:
			animation_handler.handle_animation(input_direction)
		else:
			push_warning("No Animation Handler assigned!")
		owner.velocity = input_direction * speed
		owner.move_and_slide()
