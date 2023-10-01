extends Node2D

var selected_unit = null

func _on_hud_unit_selection_changed(selected_unit):
	self.selected_unit = selected_unit

func _on_map_cell_clicked(col, row, friendly):
	if self.selected_unit != null:
		$Map.spawn_friendly_unit_at(selected_unit, col, row)
