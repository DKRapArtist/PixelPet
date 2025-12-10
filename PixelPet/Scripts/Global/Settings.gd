extends Node
class_name Settings

const SAVE_PATH := "user://settings.cfg"

var data := {
	"master_volume": 1.0,
	"music_volume": 1.0,
	"sfx_volume": 1.0,

	"music_muted": false, 
	"sfx_muted": false,
}

func _ready():
	load_settings()
	apply_audio_settings()

func get_value(key: String, default_value):
	return data.get(key, default_value)

func set_value(key: String, value):
	data[key] = value
	save_settings()

func save_settings():
	var cfg := ConfigFile.new()

	for key in data.keys():
		cfg.set_value("audio", key, data[key])

	cfg.save(SAVE_PATH)

func load_settings():
	var cfg := ConfigFile.new()
	if cfg.load(SAVE_PATH) != OK:
		return

	for key in data.keys():
		data[key] = cfg.get_value("audio", key, data[key])

func apply_audio_settings():
	_apply_bus("Master", data["master_volume"], false)
	_apply_bus("Music", data["music_volume"], data["music_muted"])
	_apply_bus("SFX", data["sfx_volume"], data["sfx_muted"])

func _apply_master():
	var bus := AudioServer.get_bus_index("Master")
	if data["master_muted"]:
		AudioServer.set_bus_mute(bus, true)
	else:
		AudioServer.set_bus_mute(bus, false)
		AudioServer.set_bus_volume_db(bus, linear_to_db(data["master_volume"]))

func _apply_bus(bus_name: String, volume: float, muted: bool):
	var bus := AudioServer.get_bus_index(bus_name)

	if muted:
		AudioServer.set_bus_mute(bus, true)
	else:
		AudioServer.set_bus_mute(bus, false)
		AudioServer.set_bus_volume_db(bus, linear_to_db(volume))
