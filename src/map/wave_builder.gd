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

@onready var count_down = $HelpContainer/CountDown
@onready var wave_timer = $WaveTimer

var current_level = 0
var points_per_level = 100

func _ready():
	ScoreManager.points_changed.connect(_on_points_changed)

func _process(_delta: float) -> void:
	count_down.text = str(floor(wave_timer.time_left))

func _on_wave_timer_timeout():
	$HelpContainer.visible = false
	
	randomize()
	
	# LevelConfiguration
	var lc = level_configurations[current_level]
	spawners = spawners.filter(func(s): return s.is_active)
	if spawners.size() == 0:
		return
	spawners.shuffle()
	for i in lc["spawner_count"]:
		# When multiple spawn in the same
		if i >= spawners.size():
			await get_tree().create_timer(1.0).timeout
		var s = spawners[i % spawners.size()]
		s.spawn_enemies(
			int(floor(lc["enemy_count"] / lc["spawner_count"])),
			lc["enemy_types"]
		)

func _on_points_changed(points: int) -> void:
	current_level = int(floor(points / float(points_per_level)))
	current_level = min(current_level, level_configurations.size() - 1)
