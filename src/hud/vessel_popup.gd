extends ColorRect

signal new_crew_accepted(crew: Array)
signal new_crew_rejected(crew: Array)

@export var max_crew_size = 6

# Todo add weight
var npc_types = [
	preload("res://src/npc/farmer/farmer.tscn"),
	preload("res://src/npc/builder/builder.tscn"),
	preload("res://src/npc/soldier/soldier.tscn"),
	preload("res://src/npc/alien/alien.tscn"), 
]  

var crew: Array = []
var remaining_days = 0

func _ready() -> void:
	self.visible = false
	
func _reset() -> void:
	remaining_days = randi_range(1, 2)
	_generate_random_crew()
	_display_crew()
	self.visible = true	
	
func _generate_random_crew() -> void:
	crew.clear()
	var crew_size = randi_range(1, max_crew_size)
	for i in crew_size:
		var rand_index:int = randi() % npc_types.size()	
		crew.append(npc_types[rand_index].instantiate())
		
func _display_crew() -> void:
	for c in $Crew.get_children():
		remove_child(c)
		c.queue_free()
	for i in crew:
		$Crew.add_child(_get_npc_rect(i))

func _get_npc_rect(npc) -> ColorRect:
	var rect = ColorRect.new()
	rect.custom_minimum_size = Vector2(50, 50)
	if npc is Farmer:
		rect.color = Color.GREEN
	elif npc is Builder:
		rect.color = Color.YELLOW
	elif npc is Soldier:
		rect.color = Color.BLUE
	elif npc is Alien:
		rect.color = Color.RED
	return rect

func _on_accept_pressed() -> void:
	new_crew_accepted.emit(crew)
	self.visible = false
	
func _on_decline_pressed() -> void:
	new_crew_rejected.emit(crew)
	self.visible = false	

func _on_day_timer_timeout() -> void:
	if not self.visible:
		if remaining_days <= 0:
			_reset()
		else:
			remaining_days -= 1 	

