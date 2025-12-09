extends Control
class_name NeedsPanel

@onready var hunger_bar = $Panel/HungerBar
@onready var thirst_bar = $Panel/ThirstBar
@onready var love_bar = $Panel/LoveBar

var pet: BasePet = null

func _process(_delta: float) -> void:
	var main := get_tree().current_scene
	if main == null or !"pet" in main:
		return

	pet = main.pet as BasePet
	if pet == null:
		return

	hunger_bar.value = PetStatsGlobal.hunger
	thirst_bar.value = PetStatsGlobal.thirst
	love_bar.value = pet.love
