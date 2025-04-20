extends Node

class_name GlobalConstants

enum FactoryObject {
	BirdHouse,
	Space
}

enum GlobalGroup {
	ITEM_OWNER,
	Y_SORT_MARKER,
	IGNORE_Y_SORT
}

static var GlobalGroupName : Dictionary = {
	GlobalGroup.ITEM_OWNER : "item_owner",
	GlobalGroup.Y_SORT_MARKER : "y_sort_marker",
	GlobalGroup.IGNORE_Y_SORT : "ignore_y_sort"
}

static func GetGroupName(group: GlobalGroup) -> String:
	return GlobalGroupName[group]