class_name Unit
extends Node2D

enum Team {
	ALLY = 1,
	ENEMY = -1
}

signal at_range()
signal not_at_range()

@export var hurtbox: HurtBox
@export var enemy_detector: Area2D
@export var animation_player: AnimationPlayer

@export var speed := 100
@export var team: Team = Team.ALLY
@export var points := 10

var enemies_in_range = 0
var can_attack = false

var blood_splatter_scene = preload("res://src/units/blood_splatter/blood_splatter.tscn")

func _ready() -> void:
	enemy_detector.area_entered.connect(_on_enemy_detector_area_entered)
	enemy_detector.area_exited.connect(_on_enemy_detector_area_exited)
	at_range.connect(_on_at_range)
	hurtbox.died.connect(_on_died)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not can_attack:
		position.y -= speed * delta * team

func _on_enemy_detector_area_entered(area: Area2D) -> void:
	enemies_in_range += 1
	if enemies_in_range > 0 and not can_attack:
		can_attack = true
		at_range.emit()

func _on_enemy_detector_area_exited(area: Area2D) -> void:
	enemies_in_range -= 1
	if enemies_in_range <= 0 and can_attack:
		can_attack = false		
		not_at_range.emit()
	
func _on_at_range() -> void:
	if animation_player.has_animation("attack"):
		animation_player.play("attack")

func _on_not_at_range() -> void:
	if animation_player.has_animation("idle"):
		animation_player.play("idle")
	elif animation_player.is_playing():
		animation_player.stop()

func _on_died() -> void:
	var blood = blood_splatter_scene.instantiate()
	blood.position = position
	blood.team = team
	get_parent().add_child(blood)
	
	queue_free()
	
