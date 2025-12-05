extends Control
class_name NeedsPanel

@export var pet_path: NodePath

@onready var hunger_bar: ProgressBar = $CanvasLayer/Panel/VBoxContainer/Hunger/HungerBar
@onready var thirst_bar: ProgressBar = $CanvasLayer/Panel/VBoxContainer/Thirst/ThirstBar
@onready var affection_bar: ProgressBar = $CanvasLayer/Panel/VBoxContainer/Affection/AffectionBar

var pet: BasePet = null

func _ready() -> void:
	if pet_path != NodePath():
		pet = get_node(pet_path) as BasePet
	else:
		push_error("NeedsPanel: pet_path not assigned!")

func _process(_delta: float) -> void:
	if pet == null:
		return

	hunger_bar.value = pet.hunger
	thirst_bar.value = pet.thirst
	affection_bar.value = pet.happiness
