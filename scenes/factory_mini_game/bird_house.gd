class_name BirdHouse
extends Node2D

enum State {
  Base,
  Hit,
}

@export var speed: float = 200
@export var state: State = State.Base
@onready var sprite: Sprite2D = %Sprite2D

var bird_house: Texture = preload("res://assets/bird_house.png")
var bird_house_built: Texture = preload("res://assets/bird_house_built.png")

func _ready() -> void:
	handle_state_change()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += Vector2(speed * delta, 0)

func hit() -> void:
	state = State.Hit
	handle_state_change()

func handle_state_change() -> void:
	match state: 
		State.Base:
			sprite.texture = bird_house
		State.Hit:
			sprite.texture = bird_house_built
