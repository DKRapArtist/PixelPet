extends Node2D

@export var default_pet_scene: PackedScene

var pet: BasePet
@onready var pet_spawn_point: Node2D = $BasePetSpawn

func _ready() -> void:
	var scene_to_use := default_pet_scene

	if PetSelectionGlobal.selected_pet_scene_path != "":
		var loaded := load(PetSelectionGlobal.selected_pet_scene_path)
		if loaded is PackedScene:
			scene_to_use = loaded

	if scene_to_use == null:
		push_error("scene_to_use is null")
		return

	spawn_pet(scene_to_use)

func spawn_pet(scene_to_use: PackedScene) -> void:
	if pet and is_instance_valid(pet):
		pet.queue_free()

	pet = scene_to_use.instantiate() as BasePet
	add_child(pet)
	pet.global_position = pet_spawn_point.global_position

func _on_radio_pressed() -> void:
	MusicManagerGlobal.next_track()
