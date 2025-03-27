extends ControllerComponent

class_name PlayerControllerComponent

@export var animation_handler: AnimationHandler

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not self._is_active_controller:
		return
	# Handle player movement
	if Dialogic.current_timeline == null:
		var input_direction: Vector2 = self._get_input_dir()
		if animation_handler:
			animation_handler.handle_animation(input_direction)
		else:
			push_warning("No Animation Handler assigned!")
		self._apply_velocity(input_direction)
