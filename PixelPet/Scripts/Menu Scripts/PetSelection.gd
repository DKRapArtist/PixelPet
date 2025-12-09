extends Control

@export var pet_buttons: Array[TextureButton] = []   # drag all pet buttons here in inspector
var selected_button: TextureButton = null

func _ready() -> void:
	for b in pet_buttons:
		b.pressed.connect(_on_pet_button_pressed.bind(b))

func _on_pet_button_pressed(button: TextureButton) -> void:
	# 1) clear old highlight
	if selected_button != null:
		selected_button.modulate = Color(1, 1, 1)  # normal

	# 2) set new selection
	selected_button = button
	selected_button.modulate = Color(1.2, 1.2, 1.2)  # simple highlight

func _on_confirm_button_pressed() -> void:
	SfxManagerGlobal.play("ButtonClick")
	if selected_button == null:
		return  # nothing chosen yet

	# assume each button has an exported scene path:
	var pet_scene_path: String = selected_button.pet_scene_path
	PetSelectionGlobal.selected_pet_scene_path = pet_scene_path
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")
