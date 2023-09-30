extends Node3D

var rotating = false

var prev_mouse_position
var next_mouse_position

const zoom_inc = 10
const rotation_sensibility = 0.1

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
		
	var new_camera_transform = null
	if (Input.is_action_just_released("ZoomIn")):
		new_camera_transform = Transform3D($Camera3D.transform)
		new_camera_transform.origin.z += zoom_inc
	if (Input.is_action_just_released("ZoomOut")):
		new_camera_transform = Transform3D($Camera3D.transform)
		new_camera_transform.origin.z += -zoom_inc
		
	if new_camera_transform:
		$Camera3D.transform = $Camera3D.transform.interpolate_with(new_camera_transform, 0.4)
