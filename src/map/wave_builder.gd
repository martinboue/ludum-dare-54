class_name WaveBuilder
extends Node

var spawners: Array[Spawner]

var level_configurations = [
	{
		"enemy_count": 1,
		"spawner_count": 1,
		"enemy_types": [1],
		"score_to_reach": 0
	},
	{
		"enemy_count": 2,
		"spawner_count": 2,
		"enemy_types": [1],
		"score_to_reach": 0
	},
	{
		"enemy_count": 2,
		"spawner_count": 2,
		"enemy_types": [1, 2],
		"score_to_reach": 0
	},
	{
		"enemy_count": 3,
		"spawner_count": 3,
		"enemy_types": [1, 2],
		"score_to_reach": 0
	},
	{
		"enemy_count": 3,
		"spawner_count": 3,
		"enemy_types": [1, 2, 0],
		"score_to_reach": 0
	},
	{
		"enemy_count": 4,
		"spawner_count": 4,
		"enemy_types": [1, 2, 0],
		"score_to_reach": 0
	},
	{
		"enemy_count": 6,
		"spawner_count": 4,
		"enemy_types": [1, 2, 0],
		"score_to_reach": 0
	},
	{
		"enemy_count": 8,
		"spawner_count": 4,
		"enemy_types": [1, 2, 0],
		"score_to_reach": 0
	}
]

var current_level = 0

func _on_wave_timer_timeout():
	var configuration = level_configurations[current_level]
	for s in spawners:
		if s.is_active:
			s.spawn_enemy()

func _on_change_level_timer_timeout() -> void:
	current_level += 1
	current_level = max(current_level, level_configurations.size())
