extends Node
class_name ControllerOrchestrator

@export var controllers: Array[ControllerComponent]
var _active_controller_index: int = 0 

func _ready() -> void:
	print("ControllerOrchestrator on ready")
	controllers[self._active_controller_index].activate()

func switch_active_controller() -> void:
	for controller in controllers:
		controller.deactivate()
	self._active_controller_index += 1
	self._active_controller_index %= controllers.size()
	controllers[self._active_controller_index].activate()
