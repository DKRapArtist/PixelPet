extends Node2D

@export var default_pet_scene: PackedScene

var pet: BasePet
@onready var pet_spawn_point: Node2D = $BasePetSpawn

#day/night management
@onready var day_time: Control = $DayTime
@onready var night_time: Control = $NightTime

func _ready() -> void:
	SaveSystemGlobal.load_game()
	_update_day_night_visibility()

	MusicManagerGlobal.start_music_once()

	var scene_to_use := default_pet_scene

	# ✅ Restore last used pet via ID if needed
	if PetSelectionGlobal.selected_pet_scene_path == "" and WalletGlobal.selected_pet_id != "":
		PetSelectionGlobal.selected_pet_scene_path = PetDatabaseGlobal.get_scene_path(WalletGlobal.selected_pet_id)

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
	add_child(pet)  # 👈 must be FIRST
	pet.global_position = pet_spawn_point.global_position

	pet.stats.apply_time_decay()  # 👈 now stats exists

	# ✅ COMMIT last-used pet ID based on scene path
	if PetSelectionGlobal.selected_pet_scene_path != "":
		for pet_id in PetDatabaseGlobal.pets.keys():
			if PetDatabaseGlobal.pets[pet_id] == PetSelectionGlobal.selected_pet_scene_path:
				WalletGlobal.selected_pet_id = pet_id
				break

		SaveSystemGlobal.save_game()

func _on_radio_pressed() -> void:
	MusicManagerGlobal.next_track()

#REAL TIME DAY / NIGHT MANAGEMENT
func is_real_time_night() -> bool:
	var t := Time.get_time_dict_from_system()  # {hour, minute, second}
	return t.hour >= 18 or t.hour < 6  # night after 18:00 and before 06:00

func _update_day_night_visibility() -> void:
	var night := is_real_time_night()

	if night:
		day_time.visible = false
		night_time.visible = true
	else:
		day_time.visible = true
		night_time.visible = false
