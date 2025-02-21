extends Node2D
# set it as start -> spawn_start or finish -> spawn_end of the room
@export var spawn_type : String
var index : int 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if spawn_type == "spawn_start":
		index = 0
	if spawn_type == "spawn_end":
		index = 1
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
