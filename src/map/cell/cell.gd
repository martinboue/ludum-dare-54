# Cell
extends Node2D

@onready var timer = $Timer
@onready var label = $Label

func _ready() -> void:
	label.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if label.visible:
		label.text = str(floor(timer.time_left))

func _on_area_2d_area_entered(_area: Area2D) -> void:
	timer.start()
	label.visible = true
