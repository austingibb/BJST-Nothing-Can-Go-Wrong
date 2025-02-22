extends Node2D

enum FactoryObject {
	BirdHouse,
	Space
}

@onready var timer:Timer = $Timer

# demo sequence
var sequence: Array[FactoryObject] = [
	FactoryObject.BirdHouse,
	FactoryObject.BirdHouse,
	FactoryObject.BirdHouse,
	FactoryObject.BirdHouse,
	FactoryObject.Space,
	FactoryObject.BirdHouse,
	FactoryObject.Space,
	FactoryObject.BirdHouse,
	FactoryObject.Space,
	FactoryObject.BirdHouse,
]

func _ready() -> void:
	timer.start()

# on timeout checks if there is something in seq
# if there is instantiates it and adds that child
# Note: This dosent handle movement, that should 
# be in the child node
func _on_timer_timeout() -> void:
	const bird_house = preload("res://scenes/factory_mini_game/bird_house.tscn")
	if sequence.is_empty():
		timer.stop()
	else:
		var currObject: FactoryObject = sequence.pop_front()
		match currObject:
			FactoryObject.BirdHouse:
				var factory_object: BirdHouse = bird_house.instantiate()
				add_child(factory_object)
			_:
				pass
  
