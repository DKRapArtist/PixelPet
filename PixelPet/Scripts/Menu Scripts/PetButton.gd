extends TextureButton
class_name PetSelectButton

@export var pet_id: String              # UNIQUE ID (e.g. "cat", "dog", "dragon")
@export var pet_scene_path: String      # e.g. res://pets/Cat.tscn
@export var select_sound: String = "PetSelect_Default"

func set_locked() -> void:
	disabled = true
	modulate = Color(0.5, 0.5, 0.5)

func set_unlocked() -> void:
	disabled = false
	modulate = Color.WHITE
