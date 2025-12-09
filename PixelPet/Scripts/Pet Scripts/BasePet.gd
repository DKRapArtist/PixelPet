extends Node2D
class_name BasePet

@export var love: float = 0.0
@export var pet_id: String = ""
@export var hunger_drain_rate: float = 2.0
@export var thirst_drain_rate: float = 2.0

@onready var area: Area2D = $Area2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	area.input_event.connect(_on_area_input_event)
	
	if sprite.sprite_frames.has_animation("Idle"):
		sprite.play("Idle")   # ✅ ALWAYS start idle
		
	set_process(true)
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

func use_item(item_type: String) -> void:
	match item_type:
		"food":
			PetStatsGlobal.hunger = clamp(PetStatsGlobal.hunger + 20.0, 0.0, 100.0)
		"water":
			PetStatsGlobal.thirst = clamp(PetStatsGlobal.thirst + 20.0, 0.0, 100.0)
		"treat":
			love = clamp(love + 15.0, 0.0, 100.0)

func on_clicked() -> void:
	if sprite.animation != "Happy" and sprite.sprite_frames.has_animation("Happy"):
		sprite.play("Happy")

func _on_area_input_event(_viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("PET CLICKED")
		print("Selected item before feed:", SelectedItemGlobal.selected_item_type)

		# ✅ FEED FIRST
		if SelectedItemGlobal.selected_item_type != "":
			use_item(SelectedItemGlobal.selected_item_type)
			print("USED ITEM:", SelectedItemGlobal.selected_item_type)

			# ✅ CLEAR AFTER FEEDING
			SelectedItemGlobal.clear()

		on_clicked()

func _on_anim_finished() -> void:
	if sprite.sprite_frames.has_animation("Idle"):
		sprite.play("Idle")
