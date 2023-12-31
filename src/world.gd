extends Node2D

var selected_unit = null
@onready var map: Map = $Map
@onready var indicator: Sprite2D = $ColIndicator
@onready var indicator_width: float = indicator.texture.get_width() * indicator.scale.x

func _ready() -> void:
	ScoreManager.points = 0

func _on_hud_unit_selection_changed(unit):
	selected_unit = unit
	if selected_unit == null:
		indicator.visible = false

func _on_map_cell_clicked(col, row, _friendly):
	if selected_unit != null:
		map.spawn_friendly_unit_at(selected_unit, col, row)

func _on_map_cell_hovered(col, _row, _friendly):
	if selected_unit != null:
		indicator.visible = true
		indicator.position.x = col * map.cell_width - indicator_width/4
