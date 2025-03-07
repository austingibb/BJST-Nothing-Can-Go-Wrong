extends Node

class_name YSortDaemon

@export var y_sort_root: Array[Node] # An array of Item-based scenes

var PRINT_FREQUENCY : int = 60

func _process(_delta: float) -> void:
	if not y_sort_root or y_sort_root.size() == 0:
		return

	# BFS through y_sort_root, looking for 'Item' nodes
	var to_visit : Array[Node] = y_sort_root.duplicate()
	while to_visit.size() > 0:
		var current_node : Node = to_visit.pop_front()

		# Enqueue children
		for child_node in current_node.get_children():
			to_visit.append(child_node)

		# If this node is an Item
		if current_node is BjstItem:
			_y_sort_item(current_node)

#
# Helper Functions
#
# We might find these to be generally useful, so we'll put them in a separate section eventually.
#

func _find_marker_node(item_node: Node) -> Marker2D:
	for child_node in item_node.get_children():
		if child_node.get_groups().find(GlobalConstants.GetGroupName(GlobalConstants.GlobalGroup.Y_SORT_MARKER)) != -1\
			and child_node is Marker2D:
			return child_node
	return null

func _y_sort_item(item: Node) -> void:
	var y_sort_marker : Marker2D = _find_marker_node(item)
	var item_y_pos : float
	if y_sort_marker:
		item_y_pos = y_sort_marker.global_position.y
	else:
		# If no y_sort_marker is found, use the center of the item's shape
		var result : Array = _get_global_center_y(item)
		var successfully_got_global_center : bool = result[0]
		item_y_pos = result[1]
		if not successfully_got_global_center:
			return

	# use sigmoid function to set a z index that has an upper bound of 100 and a lower bound of 0
	# a normalized sigmoid is an s-shaped curve that ranges from 0 to 1
	# we can use this to set the z index of the item
	item.owner.z_index = clamp(100/(1+pow(2, -item_y_pos/200.0)), 0, 100)
	if Engine.get_frames_drawn() % PRINT_FREQUENCY == 0:
		print("Z index set to ", item.owner.z_index, " for y pos ", item_y_pos)

# Finds the body node under an owner node (only looks at direct children, not grandchildren, etc...): A body node is one of these: Area2D, CharacterBody2D, or StaticBody2D
func _find_body_node(owner_node: Node) -> Node:
	for child_node : Node in owner_node.get_children():
		if child_node is Area2D or child_node is CharacterBody2D or child_node is StaticBody2D:
			return child_node
	return null

# Finds the shape (CollisionShape2D/CollisionPolygon2D) under a body node
func _find_shape_node(body_node: Node) -> Node:
	for shape in body_node.get_children():
		if shape is CollisionShape2D or shape is CollisionPolygon2D:
			return shape
	return null

# Returns (bool, float). bool indicates success, float is the center Y.
func _get_global_center_y(item: Node) -> Array:
	var item_owner : Node = item.owner
	if not item_owner:
		return [false, 0.0]

	var body_node : Node = _find_body_node(item_owner)
	if not body_node:
		return [false, 0.0]

	var shape_node : Node = _find_shape_node(body_node)
	if not shape_node:
		return [false, 0.0]

	return [true, shape_node.get_global_position().y]
