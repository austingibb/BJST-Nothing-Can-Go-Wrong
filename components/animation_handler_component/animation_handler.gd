extends Node
class_name AnimationHandler

@export var animated_sprite2d: AnimatedSprite2D

func handle_animation(input_direction: Vector2) -> void:
	if animated_sprite2d:
		if input_direction != Vector2.ZERO:
			if input_direction.x > 0 and input_direction.y < 0:
				animated_sprite2d.play("NE")
				animated_sprite2d.flip_h = false
			elif input_direction.x > 0 and input_direction.y > 0:
				animated_sprite2d.play("SE")
				animated_sprite2d.flip_h = false
			elif input_direction.x < 0 and input_direction.y < 0:
				animated_sprite2d.play("NE")
				animated_sprite2d.flip_h = true
			elif input_direction.x < 0 and input_direction.y > 0:
				animated_sprite2d.play("SE")
				animated_sprite2d.flip_h = true
			elif input_direction.x > 0:
				animated_sprite2d.play("E")
				animated_sprite2d.flip_h = false
			elif input_direction.x < 0:
				animated_sprite2d.play("E")
				animated_sprite2d.flip_h = true
			elif input_direction.y < 0:
				animated_sprite2d.play("N")
			elif input_direction.y > 0:
				animated_sprite2d.play("S")
		else:
			animated_sprite2d.play("idle")  # Play idle animation when not moving
	else:
		push_warning("No AnimatedSprite2D assigned!")
