extends Node
class_name MusicManager

var tracks: Array[AudioStream] = []
var player: AudioStreamPlayer
var current_index: int = 0
var initialized := false
var has_played_once := false
var has_started := false

const SAVE_PATH := "user://music_save.cfg"

func _ready() -> void:
	if initialized:
		return
	initialized = true

	_load_last_index()

	tracks.append(load("res://Assets/PixelPet Music/Pixel Pet Theme 1.wav"))
	tracks.append(load("res://Assets/PixelPet Music/Pixel Pet Theme 2.wav"))
	tracks.append(load("res://Assets/PixelPet Music/Pixel Pet Theme 3.wav"))
	tracks.append(load("res://Assets/PixelPet Music/Pixel Pet Theme 4.wav"))

	player = AudioStreamPlayer.new()
	player.bus = "Music"
	add_child(player)

func _load_last_index() -> void:
	var cfg := ConfigFile.new()
	var err := cfg.load(SAVE_PATH)
	if err == OK:
		current_index = int(cfg.get_value("music", "current_index", 0))

func _save_current_index() -> void:
	var cfg := ConfigFile.new()
	cfg.set_value("music", "current_index", current_index)
	cfg.save(SAVE_PATH)

func start_music_once() -> void:
	if has_started:
		return
	has_started = true
	if tracks.size() > 0:
		player.stream = tracks[current_index]
		player.play()

func play_track(index: int) -> void:
	if index < 0 or index >= tracks.size():
		return
	current_index = index
	_save_current_index()
	player.stream = tracks[current_index]
	player.play()
	has_played_once = true

func next_track() -> void:
	if tracks.size() == 0:
		return
	current_index = (current_index + 1) % tracks.size()
	play_track(current_index)
