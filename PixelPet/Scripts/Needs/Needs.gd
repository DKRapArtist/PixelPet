extends Control
class_name NeedsPanel

@onready var hunger_bar = $Panel/HungerBar
@onready var thirst_bar = $Panel/ThirstBar
@onready var love_bar = $Panel/LoveBar

var pet: BasePet = null

func _process(_delta: float) -> void:
	var main := get_tree().current_scene
	if main == null:
		return

	if not ("pet" in main):
		return

	var current_pet := main.pet as BasePet
	if current_pet == null or current_pet.stats == null:
		return

	hunger_bar.value = current_pet.stats.hunger
	thirst_bar.value = current_pet.stats.thirst
	love_bar.value = current_pet.love
