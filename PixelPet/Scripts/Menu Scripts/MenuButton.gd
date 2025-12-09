extends Control

func _on_menu_button_pressed() -> void:
	SfxManagerGlobal.play("ButtonClick")
	get_tree().change_scene_to_file("res://Scenes/Menu/Menu.tscn")
