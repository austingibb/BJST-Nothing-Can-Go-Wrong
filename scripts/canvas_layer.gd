extends CanvasLayer

var bus_audio : int
var confirm_panel : Panel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  bus_audio = AudioServer.get_bus_index("Master")
  var value : int = db_to_linear(AudioServer.get_bus_volume_db(bus_audio))
  confirm_panel = get_node("ConfirmPanel")
  confirm_panel.visible = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
  pass
  
func _on_h_slider_value_changed(value: float) -> void:
  AudioServer.set_bus_volume_db(bus_audio, linear_to_db(value / 100))

func _on_save_button_pressed() -> void:
  LevelManager.save_game()

func _on_exit_button_pressed() -> void:
  if LevelManager.is_saved:
    get_tree().quit()
  else:
    confirm_panel.visible = true

func _on_no_button_pressed() -> void:
  confirm_panel.visible = false

func _on_yes_button_pressed() -> void:
  get_tree().quit()
