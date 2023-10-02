class_name WaveBuilder
extends Node

var spawners: Array[Spawner]

var enemy_scenes = [
	preload("res://src/units/enemies/archer/enemy_archer.tscn"),
	preload("res://src/units/enemies/soldier/enemy.tscn"),
	preload("res://src/units/enemies/shielder/enemy_shielder.tscn")
]

var level_configurations = [
	{
		"enemy_count": 1,
		"spawner_count": 1,
		"enemy_types": [enemy_scenes[1]],
		"score_to_reach": 0
	},
	{
		"enemy_count": 2,
		"spawner_count": 2,
		"enemy_types": [enemy_scenes[1]],
		"score_to_reach": 0
	},
	{
		"enemy_count": 2,
		"spawner_count": 2,
		"enemy_types": [enemy_scenes[1], enemy_scenes[2]],
		"score_to_reach": 0
	},
	{
		"enemy_count": 3,
		"spawner_count": 3,
		"enemy_types": [enemy_scenes[1], enemy_scenes[2]],
		"score_to_reach": 0
	},
	{
		"enemy_count": 3,
		"spawner_count": 3,
		"enemy_types": [enemy_scenes[1], enemy_scenes[2], enemy_scenes[0]],
		"score_to_reach": 0
	},
	{
		"enemy_count": 4,
		"spawner_count": 4,
		"enemy_types": [enemy_scenes[1], enemy_scenes[2], enemy_scenes[0]],
		"score_to_reach": 0
	},
	{
		"enemy_count": 6,
		"spawner_count": 4,
		"enemy_types": [enemy_scenes[1], enemy_scenes[2], enemy_scenes[0]],
		"score_to_reach": 0
	},
	{
		"enemy_count": 8,
		"spawner_count": 4,
		"enemy_types": [enemy_scenes[1], enemy_scenes[2], enemy_scenes[0]],
		"score_to_reach": 0
	}
]

var current_level = 0

func _on_wave_timer_timeout():
	randomize()	
	
	# LevelConfiguration
	var lc = level_configurations[current_level]
	var spawner_used = 0
	self.spawners = self.spawners.filter(func(s): return s.is_active)
	self.spawners.shuffle()
	for s in spawners:
		if spawner_used < lc["spawner_count"]:
			spawner_used += 1
			s.spawn_enemies(
				int(floor(lc["enemy_count"] / lc["spawner_count"])),
				lc["enemy_types"]
			)
		else:
			break

func _on_change_level_timer_timeout() -> void:
	current_level += 1
	current_level = max(current_level, level_configurations.size() - 1)
