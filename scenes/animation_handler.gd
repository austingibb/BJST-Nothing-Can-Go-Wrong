class_name AnimationHandler
extends Node

@export var animated_sprite2d: AnimatedSprite2D

func handle_animation(input_direction: Vector2) -> void:
  if animated_sprite2d:
    if input_direction != Vector2.ZERO:
      if input_direction.x > 0 and input_direction.y < 0:
        animated_sprite2d.play("NE")
      elif input_direction.x > 0 and input_direction.y > 0:
        animated_sprite2d.play("SE")
      elif input_direction.x < 0 and input_direction.y < 0:
        animated_sprite2d.play("NW")
      elif input_direction.x < 0 and input_direction.y > 0:
        animated_sprite2d.play("SW")
      elif input_direction.x > 0:
        animated_sprite2d.play("E")
      elif input_direction.x < 0:
        animated_sprite2d.play("W")
      elif input_direction.y < 0:
        animated_sprite2d.play("N")
      elif input_direction.y > 0:
        animated_sprite2d.play("S")
    else:
      animated_sprite2d.play("idle")  # Play idle animation when not moving
  else:
    push_warning("No AnimatedSprite2D assigned!")
