extends Node
class_name BjstItem

func _ready() -> void:
	# continually search through parents until a node in "owner" group is found
	var item_owner_parent : Node = self
	while item_owner_parent != null:
		if GlobalConstants.GetGroupName(GlobalConstants.GlobalGroup.ITEM_OWNER) in item_owner_parent.get_groups():
			break
		if item_owner_parent.get_parent() == null:
			break
		item_owner_parent = item_owner_parent.get_parent()
	
	if item_owner_parent != null and item_owner_parent != self:
		self.set_owner(item_owner_parent)
