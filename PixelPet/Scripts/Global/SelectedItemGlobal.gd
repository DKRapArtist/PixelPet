extends Node

var selected_item_type: String = ""
var selected_icon: ItemIcon = null

func select_item(item_type: String, icon: ItemIcon) -> void:
	# Unselect previous
	if selected_icon and is_instance_valid(selected_icon):
		selected_icon.deselect()

	# Select new
	selected_item_type = item_type
	selected_icon = icon
	selected_icon.select()

	print("ITEM SELECTED:", item_type)

func clear() -> void:
	if selected_icon and is_instance_valid(selected_icon):
		selected_icon.deselect()

	selected_icon = null
	selected_item_type = ""

	# ✅ ENSURE CURSOR IS CLEARED
	CursorItemGlobal.clear()
