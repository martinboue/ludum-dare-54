extends Node

var food_count := 0
var npc_count := 0
var day_count := 0

func on_npc_spawn(npc):
	if npc is Farmer:
		food_count += 1
	npc_count += 1
	
func on_npc_die(npc):
	if npc is Farmer:
		food_count -= 1
	npc_count -= 1

func on_new_day():
	day_count += 1
	food_count = -npc_count

func get_npc_count() -> int:
	return npc_count
	
func get_food_count() -> int:
	return food_count

func get_day_count() -> int:
	return day_count
