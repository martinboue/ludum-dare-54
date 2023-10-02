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
	},
	{
		"enemy_count": 2,
		"spawner_count": 2,
		"enemy_types": [enemy_scenes[1]],
	},
	{
		"enemy_count": 2,
		"spawner_count": 2,
		"enemy_types": [enemy_scenes[1], enemy_scenes[2]],
	},
	{
		"enemy_count": 3,
		"spawner_count": 3,
		"enemy_types": [enemy_scenes[1], enemy_scenes[2]],
	},
	{
		"enemy_count": 3,
		"spawner_count": 3,
		"enemy_types": [enemy_scenes[1], enemy_scenes[2], enemy_scenes[0]],
	},
	{
		"enemy_count": 4,
		"spawner_count": 4,
		"enemy_types": [enemy_scenes[1], enemy_scenes[2], enemy_scenes[0]],
	},
	{
		"enemy_count": 6,
		"spawner_count": 4,
		"enemy_types": [enemy_scenes[1], enemy_scenes[2], enemy_scenes[0]],
	},
	{
		"enemy_count": 8,
		"spawner_count": 4,
		"enemy_types": [enemy_scenes[1], enemy_scenes[2], enemy_scenes[0]],
	}
]

var current_level = 0
var points_per_level = 100

func _ready():
	ScoreManager.points_changed.connect(_on_points_changed)
	
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

func _on_points_changed(points: int) -> void:
	current_level = int(floor(points / points_per_level))
	current_level = min(current_level, level_configurations.size() - 1)
