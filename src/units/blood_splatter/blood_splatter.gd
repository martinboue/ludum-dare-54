# Blood splatter
extends CPUParticles2D

var team: Unit.Team
var blood_ally = preload("res://src/units/blood_splatter/blood_ally.png")
var blood_enemy = preload("res://src/units/blood_splatter/blood_enemy.png")

func _ready() -> void:
	set_physics_process(false)
	texture = blood_ally if team == Unit.Team.ALLY else blood_enemy
	emitting = true
	set_physics_process(true)
	
func _physics_process(delta: float) -> void:
	if not emitting:
		queue_free()
