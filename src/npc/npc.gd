extends CharacterBody3D

@onready var planet: Node3D = get_parent()
@export var speed := 1 

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Movement
	if Input.is_action_pressed("ui_up"):
		velocity -= transform.basis.y * speed
	if Input.is_action_pressed("ui_down"):
		velocity += transform.basis.y * speed
	if Input.is_action_pressed("ui_left"):
		velocity += transform.basis.x * speed
	if Input.is_action_pressed("ui_right"):
		velocity -= transform.basis.x * speed

	# Gravity to center of planet
	if not is_on_floor():
		velocity += get_gravity_dir_vector() * gravity * delta * 100
	up_direction = get_gravity_dir_vector()
	move_and_slide()
	
	# Keep NPC up relative to the ground
	transform = transform.orthonormalized()
	if transform.basis.y.normalized().cross(get_gravity_dir_vector()) != Vector3():
		look_at(planet.global_transform.origin, transform.basis.y)
	elif transform.basis.x.normalized().cross(get_gravity_dir_vector()) != Vector3():
		look_at(planet.global_transform.origin, transform.basis.x)
	

	
func get_gravity_dir_vector():
	return (planet.transform.origin - transform.origin).normalized()
