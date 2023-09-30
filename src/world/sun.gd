extends DirectionalLight3D

@onready var timer := $DayTimer

func _process(delta: float) -> void:
	rotation.y = deg_to_rad(timer.time_left / timer.wait_time * 360)

func _on_day_timer_timeout():
	ResourceManager.on_new_day()
	
