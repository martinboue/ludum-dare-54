class_name Map
extends Node2D

signal cell_hovered(col, row, friendly)
signal cell_clicked(col, row, friendly)
signal defeat()

@onready var tilemap: TileMap = $TileMap

var cell_scene = preload("res://src/map/cell/cell.tscn")
var spawner_scene = preload("res://src/map/spawner/spawner.tscn")

# Units scenes
var unit_scenes = [
	preload("res://src/units/shielder/shielder.tscn"),
	preload("res://src/units/soldier/soldier.tscn"),
	preload("res://src/units/archer/archer.tscn")
]
var playing = true

@onready var cell_width = tilemap.tile_set.tile_size.x
@onready var cell_height = tilemap.tile_set.tile_size.y

@onready var nb_col = tilemap.get_used_rect().end.x - tilemap.get_used_rect().position.x
@onready var nb_row = tilemap.get_used_rect().end.y - tilemap.get_used_rect().position.y

var friendly_cells := 0

func _ready() -> void:
	# Generate cells on top of the map
	for col in nb_col:
		# Do not generate cells or spawner on first and last column
		if col == 0 or col == nb_col -1:
			continue
			
		var cell: Cell = null
		# Do not generate cells on 2 last rows
		for row in nb_row - 2:
			cell = cell_scene.instantiate()
			tilemap.add_child(cell)
			cell.position.x = col * cell_width + cell_width / 2.0 + tilemap.get_used_rect().position.x * cell_width
			cell.position.y = row * cell_height + cell_height / 2.0 + tilemap.get_used_rect().position.y * cell_height
			cell.col = col
			cell.row = row
			
			cell.clicked.connect(_raise_cell_clicked)
			cell.hovered.connect(_raise_cell_hovered)
			cell.friendly_changed.connect(_on_cell_friendly_changed)
			
			friendly_cells += 1
			
		# Generate col spawner
		var spawner: Spawner = spawner_scene.instantiate()
		tilemap.add_child(spawner)
		spawner.position.x = cell.position.x
		spawner.position.y = -cell_height
		cell.friendly_changed.connect(spawner.on_end_cell_is_claimed)
		$WaveBuilder.spawners.append(spawner)

func _on_cell_friendly_changed(friendly: bool):
	friendly_cells += 1 if friendly else -1
	if friendly_cells == 0:
		defeat.emit()
		
func _raise_cell_clicked(col, row, friendly) -> void:
	cell_clicked.emit(col, row, friendly)
	
func _raise_cell_hovered(col, row, friendly) -> void:
	cell_hovered.emit(col, row, friendly)
	
func spawn_friendly_unit_at(unit_type: int, col, _row) -> void:
	if not playing:
		return
	var unit = unit_scenes[unit_type].instantiate()
	unit.position.x = col * cell_width + cell_width / 2.0 + tilemap.get_used_rect().position.x * cell_width
	unit.position.y = (nb_row - 2) * cell_height + cell_height / 2.0
	tilemap.add_child(unit)
	ScoreManager.on_ally_spawn(unit, unit_type)

func _on_ally_despawner_area_entered(area: Area2D) -> void:
	if not area is HurtBox:
		return
	area.suicide()

func _on_enemy_despawner_area_entered(area: Area2D) -> void:
	if not area is HurtBox:
		return
	area.suicide()

func _on_hud_defeat() -> void:
	playing = false
