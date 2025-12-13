extends Node

var pets := {
	"kitty": "res://Scenes/Pet Scenes/KittyPet.tscn",
	"puppy": "res://Scenes/Pet Scenes/PuppyPet.tscn",
	"icecube": "res://Scenes/Pet Scenes/IceCube.tscn",
	"rock": "res://Scenes/Pet Scenes/Rock.tscn",
	"mouse": "res://Scenes/Pet Scenes/Mouse.tscn",
}

func get_scene_path(pet_id: String) -> String:
	return pets.get(pet_id, "")
