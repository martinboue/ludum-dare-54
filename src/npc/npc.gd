extends Node3D

# Variables pour stocker la position sphérique du bonhomme
var radius = 15.0  # Rayon de la sphère
var polar_angle = 0.0  # Angle polaire (en radians)
var azimuthal_angle = 0.0  # Angle azimutal (en radians)

func _process(delta: float) -> void:
	# Mettre à jour les angles en fonction des entrées utilisateur (ou d'autres sources)
	polar_angle += (Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")) * 0.1
	azimuthal_angle += (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * 0.1

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
