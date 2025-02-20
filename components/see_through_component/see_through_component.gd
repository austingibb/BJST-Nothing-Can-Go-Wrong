extends Area2D

@export var sprite: Sprite2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and sprite:
		var tween: Tween  = create_tween()
		tween.tween_property(sprite, "modulate:a", 0.50, 1.0)  # Fade out over 1 second

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player") and sprite:
		var tween: Tween = create_tween()
		tween.tween_property(sprite, "modulate:a", 1.0, 1.0)  # Fade in over 1 second
