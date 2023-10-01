# Map
extends Node2D

@onready var tilemap: TileMap = $TileMap
var cell_scene = preload("res://src/map/cell/cell.tscn")
var spawner_scene = preload("res://src/map/spawner/spawner.tscn")

func _ready() -> void:
	# Generate cells on top of the map
	var cell_width = tilemap.tile_set.tile_size.x
	var cell_height = tilemap.tile_set.tile_size.y
	
	# Generate cells on top of the map
	for col in tilemap.get_used_rect().end.x:
		for row in tilemap.get_used_rect().end.y:
			var cell = cell_scene.instantiate()
			tilemap.add_child(cell)
			cell.position.x = col * cell_width + cell_width / 2.0
			cell.position.y = row * cell_height + cell_height / 2.0
			
	# Generate spawner
	for col in tilemap.get_used_rect().end.x:
		var spawner = spawner_scene.instantiate()
		tilemap.add_child(spawner)
		spawner.position.x = col * cell_width + cell_width / 2.0
		spawner.position.y = -cell_height
