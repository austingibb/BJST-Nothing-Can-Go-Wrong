extends Node

class_name YSortDaemon

@export var player: Node	 # A CharacterBody2D-based scene
@export var y_sort_root: Node

func _process(_delta: float) -> void:
	if not player or not y_sort_root:
		return

	# Find the player's CollisionShape2D or CollisionPolygon2D
	var player_shape : Node = _find_player_shape(player)
	if not player_shape:
		return
	var player_y : float = player_shape.get_global_position().y

	# BFS through y_sort_root, looking for 'Item' nodes
	var to_visit : Array[Node] = [y_sort_root]
	while to_visit.size() > 0:
		var current_node : Node = to_visit.pop_front()

		# Enqueue children
		for child_node in current_node.get_children():
			to_visit.append(child_node)

		# If this node is an Item
		if current_node is BjstItem:
			var result : Array = _get_global_center_y(current_node)
			var successfully_got_global_center : bool = result[0]
			var center_y : float = result[1]
			if successfully_got_global_center:
				if center_y < player_y:
					current_node.owner.z_index = -1
				else:
					current_node.owner.z_index = 1

#
# Helper Functions
#
# We might find these to be generally useful, so we'll put them in a separate section eventually.
#

# Finds the player's shape (CollisionShape2D/CollisionPolygon2D)
func _find_player_shape(root_node: Node) -> Node:
	var queue : Array[Node] = [root_node]
	while queue.size() > 0:
		var candidate : Node = queue.pop_front()
		for child in candidate.get_children():
			queue.append(child)
		if candidate is CollisionShape2D or candidate is CollisionPolygon2D:
			return candidate
	return null

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
