class_name Cell
extends Node2D

@onready var timer = $Timer
@onready var label = $Label
@onready var enemy_sprite = $EnemySprite

var friendly = true
var cell_up: Cell
var cell_down: Cell

func _ready() -> void:
	label.visible = false
	enemy_sprite.visible = false

func _process(_delta: float) -> void:
	if label.visible:
		label.text = str(floor(timer.time_left))

func _on_enemy_detector_area_entered(area: Area2D) -> void:
	if friendly and timer.is_stopped():
		timer.start()
		label.visible = true

func _on_ally_detector_area_entered(area: Area2D) -> void:
	if not friendly and timer.is_stopped():
		timer.start()
		label.visible = true

func _on_timer_timeout() -> void:
	friendly = !friendly
	enemy_sprite.visible = !friendly
	label.visible = false
	
