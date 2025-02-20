extends Area2D

signal hit

func _input(event: InputEvent) -> void:
  if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
    hit.emit()
    if has_overlapping_bodies() or has_overlapping_areas():
      for item in get_overlapping_areas():
        if item.owner and item.owner.has_method("hit"):
          print("Hit Called")
          item.owner.hit()
    else:
      print("Nothing here")
