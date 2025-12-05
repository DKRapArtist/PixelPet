extends Control

var menu_open := false

func _on_menu_button_pressed() -> void:
	menu_open = !menu_open

	$Food.visible = menu_open
	$Treat.visible = menu_open
	$Drink.visible = menu_open
	$PinkSidePanel.visible = menu_open
