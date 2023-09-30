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

func _ready() -> void:
	_generate_random_crew()
	_display_crew()
	
func _generate_random_crew():
	crew.clear()
	var crew_size = randi_range(1, max_crew_size)
	for i in crew_size:
		var rand_index:int = randi() % npc_types.size()	
		crew.append(npc_types[rand_index].instantiate())
		
func _display_crew():
	for i in crew:
		$Crew.add_child(_get_npc_rect(i))

func _get_npc_rect(npc):
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

func _on_accept_pressed():
	new_crew_accepted.emit(crew)
	self.visible = false
	
func _on_decline_pressed():
	new_crew_rejected.emit(crew)
	self.visible = false	
