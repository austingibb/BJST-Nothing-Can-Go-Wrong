extends AudioStreamPlayer

var menu_music: AudioStream = preload("res://assets/audio/menu.wav")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stream = menu_music
	play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
