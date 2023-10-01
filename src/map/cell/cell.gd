class_name Cell
extends Node2D

signal clicked(col, row, friendly)
signal friendly_changed(friendly: bool)

@onready var timer = $Timer
@onready var label = $Label
@onready var enemy_sprite = $EnemySprite

var col = null
var row = null

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
	friendly_changed.emit(friendly)
	
func _on_area_2d_area_entered(_area: Area2D) -> void:
	timer.start()
	label.visible = true

func _on_selection_detector_input_event(viewport, event, shape_idx):
	if not (event is InputEventMouseButton):
		return

	if event.pressed:
		clicked.emit(col, row, friendly)
