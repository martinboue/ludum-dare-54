class_name Unit
extends Node2D

enum Direction {
	UP = 1,
	DOWN = -1
}

@export var hurtbox: HurtBox

@export var speed := 100
@export var direction: Direction = Direction.UP

var stop = false

func _ready() -> void:
	hurtbox.died.connect(_on_died)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not stop:
		position.y -= speed * delta * direction

func _on_hit_box_area_entered(area: Area2D) -> void:
	stop = true

func _on_died():
	queue_free()
