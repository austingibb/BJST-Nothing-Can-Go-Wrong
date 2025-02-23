extends Node2D

func _on_interactable_component_interacted() -> void:
	if Dialogic.current_timeline == null:
		if StoryManager.day_num == 0:
			Dialogic.start("prelude_fridge")
