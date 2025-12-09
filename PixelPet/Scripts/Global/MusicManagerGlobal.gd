extends Node
class_name MusicManager

var tracks: Array[AudioStream] = []
var player: AudioStreamPlayer
var current_index: int = 0

func _ready() -> void:
	# Fill the array here
	tracks.append(load("res://Assets/PixelPet Music/Pixel Pet Theme 1.wav"))
	tracks.append(load("res://Assets/PixelPet Music/Pixel Pet Theme 2.wav"))
	tracks.append(load("res://Assets/PixelPet Music/Pixel Pet Theme 3.wav"))
	tracks.append(load("res://Assets/PixelPet Music/Pixel Pet Theme 4.wav"))
	# add more lines for more songs

	print("MusicManager tracks size:", tracks.size())

	player = AudioStreamPlayer.new()
	add_child(player)

	if tracks.size() > 0 and tracks[0] != null:
		player.stream = tracks[0]
		player.play()
	else:
		push_warning("MusicManager: no valid tracks in array")

func play_track(index: int) -> void:
	if index < 0 or index >= tracks.size():
		return
	current_index = index
	player.stream = tracks[current_index]
	player.play()

func next_track() -> void:
	if tracks.size() == 0:
		return
	current_index = (current_index + 1) % tracks.size()
	play_track(current_index)
