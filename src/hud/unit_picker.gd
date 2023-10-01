class_name UnitPicker
extends ColorRect

@export var value :int = 0

signal selection_changed(is_selected, selected_value)

var selected = false
var mouse_hover = false

@onready var border: ColorRect = $Border
@onready var cooldown: Timer = $Cooldown
@onready var cooldown_overlay: ColorRect = $CooldownOverlay

func _ready() -> void:
	ScoreManager.ally_spawned.connect(_on_ally_spawned)

func _on_ally_spawned(spawned_value: int):
	if spawned_value == value:
		$Cooldown.start()
		unselect()

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			if mouse_hover and not selected and $Cooldown.is_stopped():
				select()
			elif mouse_hover and selected:
				unselect()

func _process(delta: float) -> void:
	cooldown_overlay.size.y = cooldown.time_left / cooldown.wait_time * size.y
	cooldown_overlay.position.y = position.y + size.y - cooldown_overlay.size.y

func select():
	selected = true
	selection_changed.emit(selected, value)

func unselect():
	selected = false
	selection_changed.emit(selected, value)

func _on_mouse_entered():
	mouse_hover = true

func _on_mouse_exited():
	mouse_hover = false

func _on_selection_changed(is_selected, selected_value):
	border.visible = is_selected
