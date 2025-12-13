extends Node

var coins: int = 0
var last_reward_time: int = 0  # store here
var bought_pets: Dictionary = {}  # keys are pet IDs or names, value is bool
var selected_pet_id: String = ""

func add_coins(amount: int) -> void:
	coins += amount

func remove_coins(amount: int) -> bool:
	if coins >= amount:
		coins -= amount
		return true
	return false

func give_hourly_reward() -> void:
	var now: int = int(Time.get_unix_time_from_system())  # cast float -> int on purpose
	if last_reward_time == 0:
		last_reward_time = now
		return

	var elapsed_seconds: int = now - last_reward_time
	var hours_passed: int = int(floor(float(elapsed_seconds) / 3600.0))

	if hours_passed > 0:
		var reward: int = hours_passed * 10
		add_coins(reward)
		last_reward_time = now
		SaveSystemGlobal.save_game()
