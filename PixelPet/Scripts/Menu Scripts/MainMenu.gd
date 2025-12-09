extends Control


func _on_pets_button_pressed() -> void:
	SfxManagerGlobal.play("ButtonClick")
	get_tree().change_scene_to_file("res://Scenes/Menu/PetSelection .tscn")


func _on_shop_button_pressed() -> void:
	SfxManagerGlobal.play("ButtonClick")
	pass # Replace with function body.


func _on_options_button_pressed() -> void:
	SfxManagerGlobal.play("ButtonClick")
	pass # Replace with function body.


func _on_back_button_pressed() -> void:
	SfxManagerGlobal.play("ButtonClick")
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")
