extends TextureRect
class_name WaterIcon

@export var item_type: String = "water"

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		SelectedItemGlobal.selected_item_type = item_type
		print("ITEM SELECTED:", item_type)
