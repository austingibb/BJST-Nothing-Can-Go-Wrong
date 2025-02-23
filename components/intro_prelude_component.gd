extends Node

func load_dialogic_timeline() -> void :
	if StoryManager.day_num == 0:
		Dialogic.start("prelude")
	elif StoryManager.day_num == 1:
		Dialogic.start("intro")
	
