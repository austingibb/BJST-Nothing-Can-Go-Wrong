class_name Nail
extends Node2D

enum NailState {
  Base,
  Hit,
  Bent
}

@export var speed: float = 200
@export var state: NailState = NailState.Base
@onready var sprite: Sprite2D = %Sprite

# signal 

var bent_nail: Texture = preload("res://assets/bent_nail.png")
var bent_nail_1: Texture = preload("res://assets/bent_nail_1.png")
var nail: Texture = preload("res://assets/nail.png")

func _ready() -> void:
	match state: 
		NailState.Bent:
			var rng: RandomNumberGenerator = RandomNumberGenerator.new()
			match rng.randi_range(0,1):
				0:
					sprite.texture = bent_nail
				1:
					sprite.texture = bent_nail_1
				_:
					sprite.texture = nail

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += Vector2(speed * delta, 0)

func hit() -> void:
	if sprite.texture:
		var height: float = sprite.texture.get_height()
		global_position += Vector2(0, height)  # Move down by the sprite's height
		#print("Moved by sprite height:", height)

	# play sound
	else:
		print("No texture found on Sprite2D")
