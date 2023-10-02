class_name Spawner
extends Marker2D

var is_active = true
var col = null
var row = null

func _ready() -> void:
	randomize()

func spawn_enemies(enemy_count: int, enemy_scenes) -> void:
	for e in enemy_count:
		var enemy = enemy_scenes.pick_random().instantiate()
		get_parent().add_child(enemy)
		enemy.position = position
		ScoreManager.on_enemy_spawn(enemy)
	
func on_end_cell_is_claimed(friendly: bool) -> void:
	self.is_active = friendly
