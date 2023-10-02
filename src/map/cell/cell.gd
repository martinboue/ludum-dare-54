class_name Cell
extends Node2D

signal hovered(col, row, friendly)
signal clicked(col, row, friendly)
signal friendly_changed(friendly: bool)

@onready var enemy_sprite = $EnemySprite

var col = null
var row = null

var friendly = true
var unit_count := 0 

func _ready() -> void:
	enemy_sprite.visible = false

func _on_enemy_detector_area_entered(area: Area2D) -> void:
	if friendly and area is HurtBox:
		unit_count += 1
		area.died.connect(_on_unit_died.bind(area))
		enemy_sprite.visible = true

func _on_unit_died(hurtbox: HurtBox):
	if not friendly:
		return
	if hurtbox.is_dead():
		unit_count -= 1
		if unit_count == 0:
			enemy_sprite.visible = false
	else:
		friendly = false
		enemy_sprite.visible = true
		friendly_changed.emit(friendly)

func _on_selection_detector_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseMotion:
		hovered.emit(col, row, friendly)
		return
	if event is InputEventMouseButton:
		if event.pressed:
			clicked.emit(col, row, friendly)
			return


