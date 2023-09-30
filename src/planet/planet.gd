extends StaticBody3D

var radius := 15

var crater_scene := preload("res://src/planet/decorations/crater_large.tscn")
var rocks_scene := preload("res://src/planet/decorations/rocks_small_a.tscn")

func _ready() -> void:
	for n in 30:
		var crater: Node3D = crater_scene.instantiate()
		put_at_random_position(crater)
		add_child(crater)
		var rocks: Node3D = rocks_scene.instantiate()
		put_at_random_position(rocks)
		add_child(rocks)

func put_at_random_position(deco: Node3D) -> void:
	var polar_angle = randi_range(0, 2 * PI)
	var azimuthal_angle = randi_range(0, 2 * PI)
	
	# Définir la position du bonhomme
	deco.transform.origin = Vector3(
		radius * sin(polar_angle) * cos(azimuthal_angle),
		radius * sin(polar_angle) * sin(azimuthal_angle), 
		radius * cos(polar_angle))
		
	# Rotation du bonhomme pour faire face au centre de la sphère
	deco.transform.basis = Basis(Vector3(0, 1, 0), Vector3(1, 0, 0), Vector3(0, 0, 1)).rotated(Vector3(1, 0, 0), -polar_angle).rotated(Vector3(0, 0, 1), azimuthal_angle - PI/2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
