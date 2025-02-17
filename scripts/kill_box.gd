extends Area2D

func _on_area_entered(area: Area2D) -> void:
  # kills anything that collides
  area.owner.queue_free()
