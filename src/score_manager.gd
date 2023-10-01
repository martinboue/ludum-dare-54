# Score manager
extends Node

signal points_changed(points: int)

var points := 0

func on_enemy_spawn(enemy: Unit):
	enemy.hurtbox.died.connect(_on_enemy_died.bind(enemy))

func _on_enemy_died(enemy: Unit):
	if enemy.hurtbox.is_dead():
		points += enemy.points
	else:
		points -= enemy.points
	points_changed.emit(points)
