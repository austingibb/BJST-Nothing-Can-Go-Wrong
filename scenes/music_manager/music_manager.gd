extends Node
class_name MusicManager

# How to add more audio tracks
# 1. add a preaload var in this file
# 2. create a enum for that file in GlobalEnum.AudioName
# 3. handle that enum in play 

var menu_music : AudioStream = preload("res://assets/audio/menu.wav")
var morning_normal: AudioStream = preload("res://assets/audio/Morning (Normal).wav")
var morning_glitchy: AudioStream = preload("res://assets/audio/Morning (Glitchy).wav")
var morning_scary : AudioStream = preload("res://assets/audio/Morning (Scary).wav")
var morning_scary2 : AudioStream = preload("res://assets/audio/Morning (scary) ver2.wav")

var bad_ending : AudioStream = preload("res://assets/audio/Bad Ending.wav")
var chaotic_confrontation : AudioStream = preload("res://assets/audio/Chaotic Confrontation.wav")
var computer_minigame : AudioStream = preload("res://assets/audio/Computer Minigame.wav")
var factory_music : AudioStream = preload("res://assets/audio/Factory.wav")
var good_ending : AudioStream = preload("res://assets/audio/Good Ending.wav")
var never_give_up : AudioStream = preload("res://assets/audio/never_give_up.wav")

@export var music_player: AudioStreamPlayer
var curr_audio: GlobalEnums.MusicName

func _ready() -> void:
	Global.music_manager = self

func play(new_music: GlobalEnums.MusicName) -> void:
	if curr_audio != new_music:
		match new_music:
			GlobalEnums.MusicName.MenuMusic : 
				curr_audio = GlobalEnums.MusicName.MenuMusic
				self.play_audio(music_player, menu_music)
			GlobalEnums.MusicName.MorningNormal : 
				curr_audio = GlobalEnums.MusicName.MorningNormal
				self.play_audio(music_player, morning_normal)
			GlobalEnums.MusicName.MorningGlitchy : 
				curr_audio = GlobalEnums.MusicName.MorningGlitchy
				self.play_audio(music_player, morning_glitchy)
			GlobalEnums.MusicName.MorningScary : 
				curr_audio = GlobalEnums.MusicName.MorningScary
				self.play_audio(music_player, morning_scary)
			GlobalEnums.MusicName.MorningScary2 : 
				curr_audio = GlobalEnums.MusicName.MorningScary2
				self.play_audio(music_player, morning_scary2)
			GlobalEnums.MusicName.BadEnding : 
				curr_audio = GlobalEnums.MusicName.BadEnding
				self.play_audio(music_player, bad_ending)
			GlobalEnums.MusicName.ChaoticConfrontation : 
				curr_audio = GlobalEnums.MusicName.ChaoticConfrontation
				self.play_audio(music_player, chaotic_confrontation)
			GlobalEnums.MusicName.ComputerMinigame : 
				curr_audio = GlobalEnums.MusicName.ComputerMinigame
				self.play_audio(music_player, computer_minigame)
			GlobalEnums.MusicName.Factory : 
				curr_audio = GlobalEnums.MusicName.Factory
				self.play_audio(music_player, factory_music)
			GlobalEnums.MusicName.GoodEnding : 
				curr_audio = GlobalEnums.MusicName.GoodEnding
				self.play_audio(music_player, good_ending)
			GlobalEnums.MusicName.NeverGiveUp : 
				curr_audio = GlobalEnums.MusicName.NeverGiveUp
				self.play_audio(music_player, never_give_up)
			_ :
				curr_audio = GlobalEnums.MusicName.MenuMusic
				self.play_audio(music_player, menu_music)

func play_audio(audio_player: AudioStreamPlayer, audio: AudioStream) -> void:
	audio_player.stream = audio
	audio_player.play()

func stop() -> void:
	curr_audio = GlobalEnums.MusicName.None
	music_player.stop()
