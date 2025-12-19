extends Control
class_name PetSelection

@export var pet_buttons: Array[PetSelectButton] = []  # drag buttons in inspector
@export var click_cooldown := 0.6  # seconds

var selected_button: PetSelectButton = null
var can_click := true


func _ready() -> void:
	for b in pet_buttons:
		b.pressed.connect(_on_pet_button_pressed.bind(b))

		# All pets are usable – no bought_pets, no coins
		b.disabled = false
		b.modulate = Color.WHITE

		if b.pet_id == WalletGlobal.selected_pet_id:
			selected_button = b
			b.modulate = Color(1.2, 1.2, 1.2)


func _on_pet_button_pressed(button: PetSelectButton) -> void:
	if not can_click:
		return

	can_click = false
	_start_cooldown()

	if selected_button:
		selected_button.modulate = Color.WHITE

	selected_button = button
	selected_button.modulate = Color(1.2, 1.2, 1.2)

	# Save selected pet globally (optional)
	WalletGlobal.selected_pet_id = button.pet_id
	SaveSystemGlobal.save_game()

	if button.select_sound != "":
		SfxManagerGlobal.play(button.select_sound)


func _start_cooldown() -> void:
	await get_tree().create_timer(click_cooldown).timeout
	can_click = true


func _on_confirm_button_pressed() -> void:
	SfxManagerGlobal.play("ButtonClick")
	if selected_button == null:
		return

	# Save selection
	WalletGlobal.selected_pet_id = selected_button.pet_id
	PetSelectionGlobal.selected_pet_scene_path = selected_button.pet_scene_path
	SaveSystemGlobal.save_game()

	get_tree().change_scene_to_file("res://Scenes/Main.tscn")
