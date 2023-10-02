class_name Spawner
extends Marker2D

var enemy_scenes = [
	preload("res://src/units/enemies/archer/enemy_archer.tscn"),
	preload("res://src/units/enemies/soldier/enemy.tscn"),
	preload("res://src/units/enemies/shielder/enemy_shielder.tscn")
]

var is_active = true
var col = null
var row = null

func _ready() -> void:
	randomize()

func spawn_enemy() -> void:
	var enemy = _get_random_enemy().instantiate()
	get_parent().add_child(enemy)
	enemy.position = position
	ScoreManager.on_enemy_spawn(enemy)
	
func _get_random_enemy() -> PackedScene:
	# Todo weight and enemies pattern
	return enemy_scenes.pick_random()
	
func on_end_cell_is_claimed(friendly: bool) -> void:
	self.is_active = friendly
