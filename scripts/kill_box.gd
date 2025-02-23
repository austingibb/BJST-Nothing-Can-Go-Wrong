extends Area2D

signal factory_object_killed

func _on_area_entered(area: Area2D) -> void:
	# kills anything that collides
	factory_object_killed.emit()
