extends Node2D

enum FactoryObject {
  Nail,
  Space
}

@onready var timer:Timer = $Timer

# demo sequence
var sequence: Array[FactoryObject] = [
  FactoryObject.Nail,
  FactoryObject.Nail,
  FactoryObject.Space,
  FactoryObject.Nail,
  FactoryObject.Space,
  FactoryObject.Nail,
  FactoryObject.Space,
  FactoryObject.Nail,
  FactoryObject.Space,
  FactoryObject.Nail,
]

func _ready() -> void:
	timer.start()

# on timeout checks if there is something in seq
# if there is instantiates it and adds that child
# Note: This dosent handle movement, that should 
# be in the child node
func _on_timer_timeout() -> void:
	const nail = preload("res://scenes/factory_mini_game/nail.tscn")
  
	if sequence.is_empty():
		timer.stop()
	else:
		var currObject: FactoryObject = sequence.pop_front()
		match currObject:
			FactoryObject.Nail:
				var factory_object: Nail = nail.instantiate()
				add_child(factory_object)
			_:
				pass
  
