extends Panel
class_name DropZone

func _can_drop_data(_pos: Vector2, data: Variant) -> bool:
	return typeof(data) == TYPE_DICTIONARY and data.has("type")

func _drop_data(_pos: Vector2, data: Variant) -> void:
	var main := get_tree().current_scene
	if main == null or !"pet" in main:
		return

	var pet := main.pet as BasePet
	if pet == null:
		return

	pet.use_item(data["type"])
