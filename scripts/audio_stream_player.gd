extends AudioStreamPlayer

@export var MAIN_MENU: AudioStream
@export var MORNING: AudioStream
@export var FACTORY: AudioStream

var current_song: AudioStream 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_song = MORNING
	stream = current_song
	play()

func change_music(room_id: int) -> void:
	stop()
	match room_id:
		3:
			current_song = FACTORY
		_:
			current_song = MORNING
	stream = current_song
	play()
