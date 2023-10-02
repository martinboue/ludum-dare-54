extends ProgressBar


func _ready() -> void:
	var unit: Unit = get_parent()
	var hurtbox: HurtBox = unit.hurtbox
	max_value = hurtbox.max_health
	value = max_value
	hurtbox.health_changed.connect(_on_health_changed)
	
	var color
	if unit.team == Unit.Team.ALLY:
		color = Color.hex(0x37D98CFF)
	else:
		color = Color.hex(0xFC5C65FF)
	get("theme_override_styles/fill").set_bg_color(color)

func _on_health_changed(health: float) -> void:
	value = health
