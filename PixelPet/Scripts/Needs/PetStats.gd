extends Node
class_name PetStats

var hunger: float = 100.0
var thirst: float = 100.0
var last_update_time: int = 0

const HUNGER_DRAIN_PER_SECOND := 0.0139  # 2 hours
const THIRST_DRAIN_PER_SECOND := 0.0278  # 1 hour

func apply_time_decay() -> void:
	var now := int(Time.get_unix_time_from_system())

	if last_update_time == 0:
		last_update_time = now
		return

	var elapsed := now - last_update_time

	hunger -= elapsed * HUNGER_DRAIN_PER_SECOND
	thirst -= elapsed * THIRST_DRAIN_PER_SECOND

	hunger = clamp(hunger, 0.0, 100.0)
	thirst = clamp(thirst, 0.0, 100.0)

	last_update_time = now
