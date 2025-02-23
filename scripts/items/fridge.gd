extends Node2D

func _on_interactable_component_interacted() -> void:
	if Dialogic.current_timeline == null:
		Dialogic.start("ball")
