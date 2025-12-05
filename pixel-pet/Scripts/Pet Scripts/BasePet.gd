extends AnimatedSprite2D
class_name BasePet

@export var hunger: float = 100.0
@export var thirst: float = 100.0
@export var happiness: float = 0.0

@export var hunger_drain_rate: float = 2.0
@export var thirst_drain_rate: float = 2.0

func _process(delta: float) -> void:
	hunger -= hunger_drain_rate * delta
	thirst -= thirst_drain_rate * delta

	hunger = clamp(hunger, 0.0, 100.0)
	thirst = clamp(thirst, 0.0, 100.0)
	happiness = clamp(happiness, 0.0, 100.0)
	
	print("Hunger:", hunger)
	print("Thirst:", thirst)
	print("Hunger:", happiness)

# ✅ Accept dragged data
func _can_drop_data(_pos: Vector2, data: Variant) -> bool:
	return typeof(data) == TYPE_DICTIONARY and data.has("type")

# ✅ Handle dropped item
func _drop_data(_pos: Vector2, data: Variant) -> void:
	use_item(data["type"])

func use_item(item_type: String) -> void:
	match item_type:
		"food":
			hunger = clamp(hunger + 20.0, 0.0, 100.0)
		"water":
			thirst = clamp(thirst + 20.0, 0.0, 100.0)
		"treat":
			happiness = clamp(happiness + 15.0, 0.0, 100.0)
