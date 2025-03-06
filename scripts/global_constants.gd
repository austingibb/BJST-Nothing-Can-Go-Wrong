extends Node

class_name GlobalConstants

enum FactoryObject {
	BirdHouse,
	Space
}

enum GlobalGroup {
	ITEM_OWNER,
	Y_SORT_MARKER
}

static var GlobalGroupName : Dictionary = {
	GlobalGroup.ITEM_OWNER : "item_owner",
	GlobalGroup.Y_SORT_MARKER : "y_sort_marker"
}

static func GetGroupName(group: GlobalGroup) -> String:
	return GlobalGroupName[group]