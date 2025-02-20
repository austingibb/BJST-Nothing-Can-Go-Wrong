class_name HighlightComponent
extends Node

@export var sprite: Sprite2D
@export var shader_material: ShaderMaterial

func highlight(enabled: bool) -> void:
  if shader_material:
    if sprite:
      if enabled:
        sprite.material = shader_material
      else:
        sprite.material = null
    else:
      push_warning("No Sprite2D assigned!")
  else:
    push_warning("No shader material assigned!")
