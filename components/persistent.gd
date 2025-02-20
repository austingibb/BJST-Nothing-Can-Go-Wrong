extends Node
class_name Persistent

@export var unique_id: String = ""  
@export var save_position: bool = true 
@export var save_state: bool = true

var data: Dictionary = {}

func get_save_data() -> Dictionary:
	data["id"] = unique_id
	if save_position and owner is Node2D:
		data["position"] = owner.position
	if save_state:
		data["state"] = get_state()
	return data

func load_from_data(save_data: Dictionary) -> void:
	if save_position and "position" in save_data:
		owner.position = save_data["position"]
	if save_state and "state" in save_data:
		set_state(save_data["state"])

func get_state() -> Dictionary:
	return {}

func set_state(state_data: Dictionary) -> void:
	pass
