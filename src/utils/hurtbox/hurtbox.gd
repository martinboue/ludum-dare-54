@icon("icon.svg")
class_name HurtBox
extends Area2D

@export var max_health := 100
var current_health: int

signal on_hurt(hitbox: HitBox)
signal died()

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	current_health = max_health

func _on_area_entered(area: Area2D) -> void:
	if not area is HitBox: 
		return
	var hitbox : HitBox = area
	
	current_health -= hitbox.damage
	if current_health <= 0:
		died.emit()
	
	on_hurt.emit(hitbox)
