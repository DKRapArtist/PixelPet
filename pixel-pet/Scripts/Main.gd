extends Node2D

@export var default_pet_scene: PackedScene

var pet: BasePet
var pet_spawn_point: Node2D

func _ready() -> void:
	pet = $Puppy
	pet_spawn_point = $BasePetSpawn

	var scene_to_use: PackedScene = default_pet_scene

	if PetSelectionGlobal.selected_pet_scene_path != "":
		var loaded := load(PetSelectionGlobal.selected_pet_scene_path)
		if loaded is PackedScene:
			scene_to_use = loaded

	if scene_to_use == null:
		push_error("scene_to_use is null")
		return

	spawn_pet(scene_to_use)

func spawn_pet(scene_to_use: PackedScene) -> void:
	if scene_to_use == null:
		push_error("spawn_pet: scene_to_use is null")
		return

	if pet != null and is_instance_valid(pet):
		pet.queue_free()

	pet = scene_to_use.instantiate() as BasePet
	if pet == null:
		push_error("spawn_pet: instantiate() returned null")
		return

	add_child(pet)
	pet.global_position = pet_spawn_point.global_position

func _on_radio_pressed() -> void:
	MusicManagerGlobal.next_track()
