extends Node2D

var selected_unit = null

func _on_hud_unit_selection_changed(selected_unit):
	self.selected_unit = selected_unit
