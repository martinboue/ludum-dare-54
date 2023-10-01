# Map
extends Node2D

@onready var tilemap: TileMap = $TileMap
var cell_scene = preload("res://src/map/cell/cell.tscn")

func _ready() -> void:
	# Generate cells on top of the map
	var cell_width = tilemap.tile_set.tile_size.x
	var cell_height = tilemap.tile_set.tile_size.y
	for col in tilemap.get_used_rect().end.x:
		for row in tilemap.get_used_rect().end.y:
			var cell = cell_scene.instantiate()
			tilemap.add_child(cell)
			cell.position.x = col * cell_width + cell_width / 2.0
			cell.position.y = row * cell_height + cell_height / 2.0
