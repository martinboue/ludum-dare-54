# Defeat
extends VBoxContainer

signal restart()

func _on_restart_button_pressed() -> void:
	restart.emit()
