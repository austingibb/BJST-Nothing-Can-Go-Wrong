extends Node2D

func _on_interactable_component_interacted() -> void:
	print("Never give up!")
	var ap : AnimationPlayer = get_node("AnimationPlayer")
	ap.play("never_give_up")
	print("You can do it!")
