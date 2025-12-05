extends Panel
class_name DropZone

@export var pet_path: NodePath
var pet: BasePet

func _ready() -> void:
	if pet_path != NodePath():
		pet = get_node(pet_path) as BasePet

func _can_drop_data(_pos: Vector2, data: Variant) -> bool:
	return typeof(data) == TYPE_DICTIONARY and data.has("type")

func _drop_data(_pos: Vector2, data: Variant) -> void:
	if pet == null:
		return

	pet.use_item(data["type"])
