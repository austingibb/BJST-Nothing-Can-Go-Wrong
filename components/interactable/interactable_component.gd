class_name InteractableComponent
extends Area2D

@export var highlighted_component: HighlightComponent

signal interacted

var can_interact: bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and can_interact:
		if has_overlapping_areas():
			for item in get_overlapping_areas():
				if item.owner.is_in_group("Player"):
					interacted.emit()

func _on_mouse_entered() -> void:
	can_interact = true
	highlight(true)

func _on_mouse_exited() -> void:
	can_interact = false
	highlight(false)

func highlight(enabled: bool) -> void:
	if highlighted_component:
		highlighted_component.highlight(enabled)
	else:
		push_warning("No Highlight Component assigned!")
