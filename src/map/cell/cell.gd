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
var unit_count := 0 

func _ready() -> void:
	label.visible = false
	enemy_sprite.visible = false

func _process(_delta: float) -> void:
	if label.visible:
		label.text = str(floor(timer.time_left))

func _on_enemy_detector_area_entered(area: Area2D) -> void:
	if friendly and timer.is_stopped() and area is HurtBox:
		unit_count = 0
		timer.start()
		label.visible = true
		unit_count += 1
		area.died.connect(_on_unit_died)

func _on_unit_died():
	unit_count -= 1
	if unit_count == 0:
		timer.stop()
		label.visible = false

func _on_timer_timeout() -> void:
	friendly = false
	enemy_sprite.visible = true
	label.visible = false
	friendly_changed.emit(friendly)

func _on_selection_detector_input_event(viewport, event, shape_idx):
	if not (event is InputEventMouseButton):
		return

	if event.pressed:
		clicked.emit(col, row, friendly)


