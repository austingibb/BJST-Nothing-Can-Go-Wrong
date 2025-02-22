extends Area2D

@onready var timer: Timer = $Timer
var can_hit: bool = true  # Prevents hitting during cooldown

signal hit

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if can_hit and (has_overlapping_bodies() or has_overlapping_areas()):
			can_hit = false  # Disable further hits
			hit.emit()
			%Hit.visible = true
			%NotHit.visible = false
			for item in get_overlapping_areas():
				if item.owner and item.owner.has_method("hit"):
					print("Hit Called")
					item.owner.hit()
			timer.start()  # Start cooldown
		else:
			print("Nothing here")

func _on_timer_timeout() -> void:
	can_hit = true  # Allow hitting again
	%Hit.visible = false
	%NotHit.visible = true
