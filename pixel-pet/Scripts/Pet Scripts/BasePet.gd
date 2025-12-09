extends Node2D
class_name BasePet

@export var love: float = 0.0
@export var pet_id: String = ""

@export var hunger_drain_rate: float = 2.0
@export var thirst_drain_rate: float = 2.0

func _ready() -> void:
	# Load stored love if exists
	if pet_id in PetStatsGlobal.love_by_pet:
		love = PetStatsGlobal.love_by_pet[pet_id]
	else:
		PetStatsGlobal.love_by_pet[pet_id] = love  # store starting value

func _process(delta: float) -> void:
	PetStatsGlobal.hunger -= hunger_drain_rate * delta
	PetStatsGlobal.thirst -= thirst_drain_rate * delta

	PetStatsGlobal.hunger = clamp(PetStatsGlobal.hunger, 0.0, 100.0)
	PetStatsGlobal.thirst = clamp(PetStatsGlobal.thirst, 0.0, 100.0)

	love = clamp(love, 0.0, 100.0)
	PetStatsGlobal.love_by_pet[pet_id] = love  # keep global copy updated

# Accept dragged data
func _can_drop_data(_pos: Vector2, data: Variant) -> bool:
	return typeof(data) == TYPE_DICTIONARY and data.has("type")

# Handle dropped item
func _drop_data(_pos: Vector2, data: Variant) -> void:
	use_item(data["type"])

func use_item(item_type: String) -> void:
	match item_type:
		"food":
			PetStatsGlobal.hunger = clamp(PetStatsGlobal.hunger + 20.0, 0.0, 100.0)
		"water":
			PetStatsGlobal.thirst = clamp(PetStatsGlobal.thirst + 20.0, 0.0, 100.0)
		"treat":
			love = clamp(love + 15.0, 0.0, 100.0)
