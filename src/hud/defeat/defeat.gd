# Defeat
extends VBoxContainer

func _ready() -> void:
	visibility_changed.connect(_on_visibility_changed)

func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://src/world.tscn")

func _on_visibility_changed():
	if visible:
		$AudioStreamPlayer.play()
