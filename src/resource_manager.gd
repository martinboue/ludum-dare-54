extends Node

var food_count := 0
var npc_count := 0
var day_count := 0

func on_npc_spawn(npc):
	npc_count += 1
	
func on_npc_die(npc):
	npc_count -= 1

func produce_food():
	food_count += 1

func consume_food():
	food_count -= 1

func get_npc_count() -> int:
	return npc_count
	
func get_food_count() -> int:
	return food_count

func get_day_count() -> int:
	return day_count
