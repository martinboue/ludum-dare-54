# Enemy Archer
extends Unit

var arrow_scene = preload("res://src/units/enemies/archer/arrow/arrow.tscn")

func shoot():
	$ShootCooldown.start()
	var arrow = arrow_scene.instantiate()
	get_parent().add_child(arrow)
	arrow.global_position = $ArrowSpawner.global_position

func _on_shot_cooldown_timeout() -> void:
	if enemies_in_range > 0:
		shoot()

func _on_archer_at_range() -> void:
	if $ShootCooldown.is_stopped():
		shoot()
