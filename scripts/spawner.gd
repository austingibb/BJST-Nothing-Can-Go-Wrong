extends Node2D


@onready var timer:Timer = $Timer
var sequence: Array[GlobalConstants.FactoryObject]

# on timeout checks if there is something in seq
# if there is instantiates it and adds that child
# Note: This dosent handle movement, that should 
# be in the child node
func _on_timer_timeout() -> void:
	const bird_house = preload("res://scenes/factory_mini_game/bird_house.tscn")
	if sequence.is_empty():
		timer.stop()
	else:
		var currObject: GlobalConstants.FactoryObject = sequence.pop_front()
		match currObject:
			GlobalConstants.FactoryObject.BirdHouse:
				var factory_object: BirdHouse = bird_house.instantiate()
				add_child(factory_object)
			_:
				pass

func _on_factory_mini_game_spawn_start(sequence: Array[GlobalConstants.FactoryObject]) -> void:
	self.sequence = sequence
	timer.start()
