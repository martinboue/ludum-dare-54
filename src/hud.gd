extends CanvasLayer

signal unit_selection_changed(selected_unit)
signal restart()

var selected_unit = null

func _ready() -> void:
	$Defeat.visible = false
	
	for c in get_tree().get_nodes_in_group("unit_picker"):
		if c is UnitPicker:
			c.selection_changed.connect(_raise_unit_selection_changed)

func _raise_unit_selection_changed(is_selected, value) -> void:
	if is_selected:
		selected_unit = value
		unit_selection_changed.emit(selected_unit)
	elif selected_unit == value:
		selected_unit = null
		unit_selection_changed.emit(selected_unit)

func _on_map_defeat() -> void:
	$Defeat.visible = true

func _on_defeat_restart() -> void:
	restart.emit()
