extends CanvasLayer

signal unit_selection_changed(selected_unit)

var selected_unit = null

func _ready() -> void:
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
