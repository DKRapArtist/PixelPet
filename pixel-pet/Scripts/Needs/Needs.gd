extends Control
class_name NeedsPanel

@onready var hunger_bar = $Panel/HungerBar
@onready var thirst_bar = $Panel/ThirstBar
@onready var love_bar = $Panel/LoveBar

var pet: BasePet = null

func _process(_delta: float) -> void:
	var main := get_tree().current_scene

	# Make sure current scene is your Main.gd scene
	if main == null or not (main is Node2D):
		return

	# Access the `pet` variable defined in Main.gd
	if "pet" in main:
		pet = main.pet as BasePet
	else:
		return

	if pet == null:
		return

	hunger_bar.value = pet.hunger
	thirst_bar.value = pet.thirst
	love_bar.value = pet.love
