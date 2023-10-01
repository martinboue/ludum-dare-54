class_name Map
extends Node2D

signal cell_clicked(col, row, friendly)
signal defeat()

@onready var tilemap: TileMap = $TileMap

var cell_scene = preload("res://src/map/cell/cell.tscn")
var spawner_scene = preload("res://src/map/spawner/spawner.tscn")

# Units scenes
var wall_scene = preload("res://src/units/shielder/shielder.tscn")

@onready var cell_width = tilemap.tile_set.tile_size.x
@onready var cell_height = tilemap.tile_set.tile_size.y

@onready var nb_col = tilemap.get_used_rect().end.x
@onready var nb_row = tilemap.get_used_rect().end.y

var friendly_cells := 0

func _ready() -> void:
	# Generate cells on top of the map
	var cell_up
	for col in nb_col:
		cell_up = null
		for row in nb_row:
			var cell: Cell = cell_scene.instantiate()
			tilemap.add_child(cell)
			cell.position.x = col * cell_width + cell_width / 2.0
			cell.position.y = row * cell_height + cell_height / 2.0
			cell.col = col
			cell.row = row
			
			cell.cell_up = cell_up
			if cell_up != null:
				cell_up.cell_down = cell
			
			cell_up = cell
			
			cell.clicked.connect(_raise_cell_clicked)
			cell.friendly_changed.connect(_on_cell_friendly_changed)
			
			friendly_cells += 1
			
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
		
func _raise_cell_clicked(col, row, friendly) -> void:
	cell_clicked.emit(col, row, friendly)
	
func spawn_friendly_unit_at(unit_type, col, row) -> void:
	# Todo handle unit type
	var unit = null
	unit = wall_scene.instantiate()
	unit.position.x = col * cell_width + cell_width / 2.0
	unit.position.y = nb_row * cell_height
	add_child(unit)
