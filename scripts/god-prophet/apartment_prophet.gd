extends Node2D

@export var ballNode : BjstBall 

func _on_cheat_manager_cheat_activated(cheat: String) -> void:
	if cheat == "change-ball-color" and is_instance_valid(ballNode):
		ballNode.toggle_color()
