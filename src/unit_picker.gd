class_name UnitPicker
extends ColorRect

@export var value :int = 0

signal selection_changed(is_selected, selected_value)

var selected = false
var mouse_hover = false

@onready var border: ColorRect = $Border

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			if mouse_hover and not selected:
				selected = true
				selection_changed.emit(selected, value)
			elif mouse_hover or selected:
				selected = false
				selection_changed.emit(selected, value)
	
func _on_mouse_entered():
	mouse_hover = true

func _on_mouse_exited():
	mouse_hover = false

func _on_selection_changed(is_selected, selected_value):
	border.visible = is_selected
