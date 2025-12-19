extends Node

const SAVE_PATH := "user://save_game.json"

func save_game() -> void:
	var data: Dictionary = {
		"selected_pet_id": WalletGlobal.selected_pet_id,
		"love_by_pet": PetStatsGlobal.love_by_pet,
	}
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data))
		file.close()

func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return

	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not file:
		return

	var text := file.get_as_text()
	file.close()

	var result: Variant = JSON.parse_string(text)
	if typeof(result) != TYPE_DICTIONARY:
		return

	var dict := result as Dictionary
	WalletGlobal.selected_pet_id = String(dict.get("selected_pet_id", ""))
	PetStatsGlobal.love_by_pet = dict.get("love_by_pet", {})
