extends Node
class_name BjstItem

# Exported flags for item aspects.
# Example flags: "ySort", "madeOfWood", "isCute", "isNostalgic". 
# Feel free to expand this to your needs for how you want to categorize in-world items.
@export_flags("ySort", "madeOfWood", "isCute", "isNostalgic") var item_aspects: int = 0
