# Archer
extends Unit

var arrow_scene = preload("res://src/units/archer/arrow/arrow.tscn")

func shoot():
	var arrow = arrow_scene.instantiate()
	get_parent().add_child(arrow)
	arrow.global_position = $ArrowSpawner.global_position

func _on_shot_cooldown_timeout() -> void:
	shoot()

func _on_archer_at_range() -> void:
	if $ShootCooldown.is_stopped():
		$ShootCooldown.start()
		
func _on_archer_not_at_range() -> void:
	if not $ShootCooldown.is_stopped():
		$ShootCooldown.stop()
	
