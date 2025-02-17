extends Node2D
var sprite: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite = $Sprite2D 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_rigid_body_2d_mouse_entered() -> void:
	sprite.scale *= 1.5 #scale for debug, need to outline black
	print("mouse over")


func _on_rigid_body_2d_mouse_exited() -> void:
	sprite.scale /= 1.5 #scale for debug, need to outline black
	print("Exited")
