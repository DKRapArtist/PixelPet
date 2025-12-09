extends Control

@export var pet_buttons: Array[TextureButton] = []   # drag all pet buttons here in inspector
@export var click_cooldown := 0.6 # seconds
var selected_button: TextureButton = null
var can_click := true

func _ready() -> void:
	for b in pet_buttons:
		b.pressed.connect(_on_pet_button_pressed.bind(b))

func _on_pet_button_pressed(button: PetSelectButton) -> void:
	if not can_click:
		return  # 🚫 ignore spam

	can_click = false
	_start_cooldown()

	# clear old highlight
	if selected_button:
		selected_button.modulate = Color.WHITE

	# select new
	selected_button = button
	selected_button.modulate = Color(1.5, 1.5, 1.5)

	# play per-pet sound
	if button.select_sound != "":
		SfxManagerGlobal.play(button.select_sound)

func _start_cooldown() -> void:
	await get_tree().create_timer(click_cooldown).timeout
	can_click = true

func _on_confirm_button_pressed() -> void:
	SfxManagerGlobal.play("ButtonClick")
	if selected_button == null:
		return  # nothing chosen yet

	# assume each button has an exported scene path:
	var pet_scene_path: String = selected_button.pet_scene_path
	PetSelectionGlobal.selected_pet_scene_path = pet_scene_path
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")
