extends Node2D

func _ready() -> void:
	if StoryManager.day_num == 0:
		Global.music_manager.play(GlobalEnums.MusicName.MorningNormal)
		Dialogic.start("prelude")
	elif StoryManager.day_num == 1 and not StoryManager.story_told:
		# TEST MUSIC
		Global.music_manager.play(GlobalEnums.MusicName.MorningGlitchy)
		StoryManager.story_told = true
		Dialogic.start("intro")
	elif StoryManager.day_num == 2:
		# TEST MUSIC
		Global.music_manager.play(GlobalEnums.MusicName.MorningScary)
		Global.scene_manager.change_gui_scene(GlobalEnums.SceneName.EndScreen)
