extends Node3D

var rotating = false

var prev_mouse_position
var next_mouse_position

const zoom_inc = 5
const rotation_sensibility = 0.5

func _process(delta):
	if (Input.is_action_just_pressed("Rotate")):
		rotating = true
		prev_mouse_position = get_viewport().get_mouse_position()
	if (Input.is_action_just_released("Rotate")):
		rotating = false
		
	if (rotating):
		next_mouse_position = get_viewport().get_mouse_position()
		rotate_y((next_mouse_position.x - prev_mouse_position.x) * rotation_sensibility * delta)
		rotate_x((next_mouse_position.y - prev_mouse_position.y) * rotation_sensibility * delta)
		
		prev_mouse_position = next_mouse_position
		
	if (Input.is_action_just_released("ZoomIn")):
		$Camera3D.fov -= zoom_inc
		
	if (Input.is_action_just_released("ZoomOut")):
		$Camera3D.fov += zoom_inc
