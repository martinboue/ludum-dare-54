# Map
extends Node2D

@onready var tilemap: TileMap = $TileMap

signal defeat()

var cell_scene = preload("res://src/map/cell/cell.tscn")
var spawner_scene = preload("res://src/map/spawner/spawner.tscn")

var friendly_cells := 0

func _ready() -> void:
	# Generate cells on top of the map
	var cell_width = tilemap.tile_set.tile_size.x
	var cell_height = tilemap.tile_set.tile_size.y
	
	# Generate cells on top of the map
	var cell_up
	for col in tilemap.get_used_rect().end.x:
		cell_up = null
		for row in tilemap.get_used_rect().end.y:
			var cell = cell_scene.instantiate()
			tilemap.add_child(cell)
			cell.position.x = col * cell_width + cell_width / 2.0
			cell.position.y = row * cell_height + cell_height / 2.0
			cell.friendly_changed.connect(_on_cell_friendly_changed)
			friendly_cells += 1
			
			cell.cell_up = cell_up
			if cell_up != null:
				cell_up.cell_down = cell
			
			cell_up = cell
			
	# Generate spawner
	for col in tilemap.get_used_rect().end.x:
		var spawner = spawner_scene.instantiate()
		tilemap.add_child(spawner)
		spawner.position.x = col * cell_width + cell_width / 2.0
		spawner.position.y = -cell_height

func _on_cell_friendly_changed(friendly: bool):
	friendly_cells += 1 if friendly else -1
	if friendly_cells == 0:
		defeat.emit()
