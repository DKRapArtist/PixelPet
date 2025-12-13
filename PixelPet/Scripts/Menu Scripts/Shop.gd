extends Control

@export var pet_buttons: Array[PetSelectButton] = []
@export var click_cooldown := 0.6
@export var pet_cost: int = 100

var selected_button: PetSelectButton = null
var can_click := true


func _ready() -> void:
	for b in pet_buttons:
		b.pressed.connect(_on_pet_button_pressed.bind(b))

		var owned = WalletGlobal.bought_pets.get(b.pet_id, false)
		b.disabled = false  # allow selecting even if locked
		b.modulate = Color.WHITE if owned else Color(0.4, 0.4, 0.4)

		if owned and b.pet_id == WalletGlobal.selected_pet_id:
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

	var owned = WalletGlobal.bought_pets.get(button.pet_id, false)
	selected_button.modulate = Color(1.2, 1.2, 1.2) if owned else Color(0.8, 0.8, 0.8)

	if button.select_sound != "":
		SfxManagerGlobal.play(button.select_sound)


func _on_buy_pressed() -> void:
	SfxManagerGlobal.play("ButtonClick")

	if selected_button == null:
		return

	var id := selected_button.pet_id
	var owned = WalletGlobal.bought_pets.get(id, false)

	if owned:
		return  # already owned, nothing to do

	if not WalletGlobal.remove_coins(pet_cost):
		SfxManagerGlobal.play("Error")
		return

	# ✅ BUY PET
	WalletGlobal.bought_pets[id] = true
	WalletGlobal.selected_pet_id = id
	SaveSystemGlobal.save_game()

	# ✅ VISUAL UNLOCK
	selected_button.modulate = Color(1.2, 1.2, 1.2)

	print("Bought pet:", id)


func _start_cooldown() -> void:
	await get_tree().create_timer(click_cooldown).timeout
	can_click = true


func _on_back_button_pressed() -> void:
	SfxManagerGlobal.play("ButtonClick")
	get_tree().change_scene_to_file("res://Scenes/Menu/Menu.tscn")
