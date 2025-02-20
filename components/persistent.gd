extends Node
class_name Persistent

@export var unique_id: String = ""
@export var is_interacted: bool = false

func _ready() -> void :
	add_to_group("Persistent")
