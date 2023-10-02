@icon("icon.svg")
class_name HurtBox
extends Area2D

@export var max_health := 100
var current_health: int

signal on_hurt(hitbox: HitBox)
signal health_changed(health: int)
signal died()

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	current_health = max_health
	health_changed.emit(current_health)

func is_dead() -> bool:
	return current_health <= 0

func _on_area_entered(area: Area2D) -> void:
	if is_dead(): 
		return

	if not area is HitBox: 
		return
	var hitbox : HitBox = area
	
	current_health -= hitbox.damage
	if is_dead():
		died.emit()
	
	health_changed.emit(current_health)

func suicide():
	died.emit()
