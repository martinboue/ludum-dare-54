# Score manager
extends Node

signal points_changed(points: int)
signal ally_spawned(value: int)

var points := 0

func on_enemy_spawn(enemy: Unit):
	enemy.hurtbox.died.connect(_on_enemy_died.bind(enemy))

func on_ally_spawn(ally: Unit, unit_value: int):
	ally.hurtbox.died.connect(_on_ally_died.bind(ally))
	ally_spawned.emit(unit_value)

func _on_enemy_died(enemy: Unit):
	if enemy.hurtbox.is_dead():
		points += enemy.points
		points_changed.emit(points)

func _on_ally_died(ally: Unit):
	if not ally.hurtbox.is_dead():
		points += ally.points
		points_changed.emit(points)

