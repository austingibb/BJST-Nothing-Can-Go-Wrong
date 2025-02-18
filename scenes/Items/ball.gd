extends Node2D

func _on_interactable_component_interacted() -> void:
	Dialogic.start("ball")
