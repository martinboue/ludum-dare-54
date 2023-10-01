# Spawner
extends Marker2D

var enemy_scene = preload("res://src/units/enemies/enemy.tscn")



func _on_spawn_cooldown_timeout() -> void:
	var enemy = enemy_scene.instantiate()
	get_parent().add_child(enemy)
	enemy.position = position
