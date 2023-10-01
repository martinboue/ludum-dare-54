# Blood splatter
extends CPUParticles2D

@export var hurtbox: HurtBox
@export var sprites: Array[Sprite2D]

var blood_ally = preload("res://src/units/blood_splatter/blood_ally.png")
var blood_enemy = preload("res://src/units/blood_splatter/blood_enemy.png")

func _ready() -> void:
	hurtbox.died.connect(_on_hurtbox_died)
	set_physics_process(false)
	if get_parent().team == Unit.Team.ALLY:
		texture = blood_ally
	else:
		texture = blood_enemy
	
func _on_hurtbox_died():
	for sprite in sprites:
		sprite.visible = false
	emitting = true
	set_physics_process(true)
	
func _physics_process(delta: float) -> void:
	if not emitting:
		get_parent().queue_free()
