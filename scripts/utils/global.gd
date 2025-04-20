extends Node

var scene_manager: SceneManager
var music_manager: MusicManager

var master_volume: float = 1.0
var music_volume: float = 1.0
var sfx_volume: float = 1.0

var debug_log: bool = false

# Helper function for conditional debug logging
func log_debug(message: String) -> void:
	if debug_log:
		print(message)
