# Spawner
extends Marker2D

var enemy_scenes = [
	preload("res://src/units/enemies/archer/enemy_archer.tscn"),
	preload("res://src/units/enemies/soldier/enemy.tscn"),
	preload("res://src/units/enemies/shielder/enemy_shielder.tscn")
]

func _ready() -> void:
	randomize()

func _on_spawn_cooldown_timeout() -> void:
	var enemy = _get_random_enemy().instantiate()
	get_parent().add_child(enemy)
	enemy.position = position
	ScoreManager.on_enemy_spawn(enemy)
	
func _get_random_enemy() -> PackedScene:
	# Todo weight and enemies pattern
	return enemy_scenes.pick_random()
