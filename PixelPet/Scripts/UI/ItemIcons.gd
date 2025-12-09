extends TextureRect
class_name ItemIcon

@export var item_type: String = ""

var is_selected := false

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		SelectedItemGlobal.select_item(item_type, self)

func select() -> void:
	is_selected = true
	modulate = Color(1.5, 1.5, 1.5) # highlight (simple + clear)

	# ✅ SHOW ON CURSOR
	CursorItemGlobal.show_item(texture)

func deselect() -> void:
	is_selected = false
	modulate = Color.WHITE

	# ✅ CLEAR CURSOR (only if this was the active one)
	if CursorItemGlobal.visible:
		CursorItemGlobal.clear()
