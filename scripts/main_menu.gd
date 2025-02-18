extends Control
var bus_audio : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bus_audio = AudioServer.get_bus_index("Master")
	var value : int = db_to_linear(AudioServer.get_bus_volume_db(bus_audio))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_audio, linear_to_db(value / 100))

func _on_button_pressed() -> void:
	get_tree().quit()
