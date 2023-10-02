extends CanvasLayer

signal unit_selection_changed(selected_unit)
signal defeat()

var selected_unit = null
var unit_pickers = []

func _ready() -> void:
	$Defeat.visible = false
	unit_pickers= get_tree().get_nodes_in_group("unit_picker")
	for c in unit_pickers:
		if c is UnitPicker:
			c.selection_changed.connect(_raise_unit_selection_changed)
	ScoreManager.points_changed.connect(_on_points_changed)

func _raise_unit_selection_changed(is_selected, value) -> void:
	if is_selected:
		selected_unit = value
		unit_selection_changed.emit(selected_unit)
		# Unselect other unit picker
		for u in unit_pickers:
			if u.value != value:
				u.unselect()
	elif selected_unit == value:
		selected_unit = null
		unit_selection_changed.emit(selected_unit)

func _on_map_defeat() -> void:
	$Defeat.visible = true
	defeat.emit()

func _on_points_changed(points: int):
	$Points.text = str(points)
