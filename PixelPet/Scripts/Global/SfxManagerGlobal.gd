extends Node
class_name SfxManager

var players: Array[AudioStreamPlayer] = []
var sounds: Dictionary = {}  # e.g. { "click": AudioStream, "feed": AudioStream }

func _ready() -> void:
	# Small pool of players so multiple sounds can overlap
	for i in 4:
		var p := AudioStreamPlayer.new()
		add_child(p)
		players.append(p)

	# Load sounds (change paths to your files) (give id in buttons inspector, match id here eg PuppySFX etc)
	sounds["ButtonClick"] = load("res://Assets/PixelPet SFX/ButtonPressSFX.wav")
	sounds["PuppySFX"] = load("res://Assets/PixelPet SFX/PetSFX/PuppySFX.wav")
	sounds["KittySFX"] = load("res://Assets/PixelPet SFX/PetSFX/KittySFX.wav")

func play(sfx_name: String) -> void:
	if not sounds.has(sfx_name):
		return
	var stream: AudioStream = sounds[sfx_name] as AudioStream
	if stream == null:
		return

	for p in players:
		if not p.playing:
			p.stream = stream
			p.play()
			return
