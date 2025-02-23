extends Node2D

func _ready() -> void:
	if StoryManager.day_num == 1 and not StoryManager.story_told:
		StoryManager.story_told = true
		Dialogic.start("intro_kitchen")
