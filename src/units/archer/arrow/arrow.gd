# Arrow
extends Node2D

@export var speed = 1000

func _process(delta: float) -> void:
	position.y -= speed * delta

func _on_hit_box_area_entered(area: Area2D) -> void:
	queue_free()
