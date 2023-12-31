# Arrow
extends Node2D

@export var speed = 1000

func _process(delta: float) -> void:
	position.y -= speed * delta

func _on_hit_box_area_entered(_area: Area2D) -> void:
	$HitBox.set_deferred("monitorable", false)
	$HitBox.set_deferred("monitoring", false)
	visible = false
	set_process(false)
	$HitPlayer.play()
	await $HitPlayer.finished
	queue_free()

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
