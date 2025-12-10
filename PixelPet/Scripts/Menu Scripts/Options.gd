extends Control

@onready var master_slider := $"VBoxContainer/Master Slider"
@onready var music_slider := $"VBoxContainer/Music Slider"
@onready var sfx_slider := $VBoxContainer/SFXSlider
@onready var music_mute_button := $VBoxContainer/MusicMuteButton
@onready var sfx_mute_button := $VBoxContainer/SFXMuteButton

func _ready():
	# Load saved values or default to 1.0
	master_slider.value = SettingsGlobal.get_value("master_volume", 1.0)
	music_slider.value = SettingsGlobal.get_value("music_volume", 1.0)
	sfx_slider.value = SettingsGlobal.get_value("sfx_volume", 1.0)

	_update_mute_ui()
	_apply_volumes()

func _apply_volumes():
	_set_bus_volume("Master", master_slider.value)
	_set_bus_volume("Music", music_slider.value)
	_set_bus_volume("SFX", sfx_slider.value)

func _set_bus_volume(bus_name: String, value: float):
	var bus := AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(bus, linear_to_db(value))

func _on_back_button_pressed() -> void:
	SfxManagerGlobal.play("ButtonClick")
	get_tree().change_scene_to_file("res://Scenes/Menu/Menu.tscn")

func _on_master_slider_value_changed(value: float):
	SettingsGlobal.set_value("master_volume", value)
	_set_bus_volume("Master", value)

func _on_music_slider_value_changed(value: float):
	SettingsGlobal.set_value("music_volume", value)
	_set_bus_volume("Music", value)

func _on_sfx_slider_value_changed(value: float):
	SettingsGlobal.set_value("sfx_volume", value)
	_set_bus_volume("SFX", value)

func _on_music_mute_button_pressed() -> void:
	var muted = !SettingsGlobal.get_value("music_muted", false)
	SettingsGlobal.set_value("music_muted", muted)

	var bus := AudioServer.get_bus_index("Music")
	AudioServer.set_bus_mute(bus, muted)

	_update_mute_ui()

func _on_sfx_mute_button_pressed() -> void:
	var muted = !SettingsGlobal.get_value("sfx_muted", false)
	SettingsGlobal.set_value("sfx_muted", muted)

	var bus := AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_mute(bus, muted)

	_update_mute_ui()

func _update_mute_ui():
	var music_muted = SettingsGlobal.get_value("music_muted", false)
	var sfx_muted = SettingsGlobal.get_value("sfx_muted", false)

	music_mute_button.texture_normal = (
		preload("res://Assets/Buttons/Unmute Music Button.png")
		if music_muted
		else preload("res://Assets/Buttons/Mute Music Button.png")
	)
	music_slider.editable = not music_muted

	sfx_mute_button.texture_normal = (
		preload("res://Assets/Buttons/Unmute SFX Button.png")
		if sfx_muted
		else preload("res://Assets/Buttons/Mute SFX Button.png")
	)
	sfx_slider.editable = not sfx_muted
