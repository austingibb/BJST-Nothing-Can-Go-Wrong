extends Node2D

@export var ball_node: BjstBall 
@export var controller_orchestrator: ControllerOrchestrator 

func _on_cheat_manager_cheat_activated(cheat: String) -> void:
	if cheat == "change-ball-color" and is_instance_valid(ball_node):
		ball_node.toggle_color()
	elif cheat == "switch-active-char":
		controller_orchestrator.switch_active_controller()
