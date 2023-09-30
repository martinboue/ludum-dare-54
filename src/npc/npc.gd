class_name Npc
extends Node3D

@export var polar_angle = 0.0  # Angle polaire (en radians)
@export var azimuthal_angle = 0.0  # Angle azimutal (en radians)

signal selection_changed(is_selected)

var radius = 15.0  # Rayon de la sphère
var is_selected = false

func _ready() -> void:
	$SelectionHighLightMesh.visible = false

func _process(delta: float) -> void:
	# Limiter les angles pour éviter les problèmes de dépassement
	polar_angle = clamp(polar_angle, -PI/2, PI/2)
	azimuthal_angle = fmod(azimuthal_angle, 2 * PI)

	# Calculer la position sphérique en utilisant les angles
	var x = radius * sin(polar_angle) * cos(azimuthal_angle)
	var y = radius * sin(polar_angle) * sin(azimuthal_angle)
	var z = radius * cos(polar_angle)

	# Définir la position du bonhomme
	transform.origin = Vector3(x, y, z)
	
	# Rotation du bonhomme pour faire face au centre de la sphère
	transform.basis = Basis(Vector3(0, 1, 0), Vector3(1, 0, 0), Vector3(0, 0, 1)).rotated(Vector3(1, 0, 0), -polar_angle).rotated(Vector3(0, 0, 1), azimuthal_angle - PI/2)

func put_at_random_position() -> void:
	polar_angle = randi_range(0, 2*PI)
	azimuthal_angle = randi_range(0, 2*PI) 

func _on_selection_area_input_event(camera, event, position, normal, shape_idx):
	if event.is_pressed() :
		is_selected = not is_selected
		selection_changed.emit(is_selected)


func _on_selection_changed(is_selected):
	$SelectionHighLightMesh.visible = is_selected
