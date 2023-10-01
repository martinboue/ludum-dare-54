class_name Unit
extends Node2D

enum Team {
	ALLY = 1,
	ENEMY = -1
}

@export var speed := 100
@export var team: Team = Team.ALLY

var stop = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not stop:
		position.y -= speed * delta * team

func _on_hit_box_area_entered(area: Area2D) -> void:
	stop = true
