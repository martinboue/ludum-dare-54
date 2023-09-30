extends ColorRect

signal new_crew_accepted(crew: Array)
signal new_crew_rejected(crew: Array)

@export var max_crew_size = 6

# Todo add weight
const npc_types = ["farmer", "builder", "soldier", "alien"]  

var crew: Array = []

func _ready() -> void:
	_generate_random_crew()
	_display_crew()
	
func _generate_random_crew():
	crew.clear()
	var crew_size = randi_range(1, max_crew_size)
	for i in crew_size:
		var rand_index:int = randi() % npc_types.size()
		crew.append(npc_types[rand_index])
		
func _display_crew():
	for i in crew:
		$Crew.add_child(_get_npc_type_rect(i))

func _get_npc_type_rect(type):
	var rect = ColorRect.new()
	rect.custom_minimum_size = Vector2(50, 50)
	if type == "farmer":
		rect.color = Color.GREEN
	elif type == "builder":
		rect.color = Color.YELLOW
	elif type == "soldier":
		rect.color = Color.BLUE
	elif type == "alien":
		rect.color = Color.RED
	return rect

func _on_accept_pressed():
	new_crew_accepted.emit(crew)
	self.visible = false
	
func _on_decline_pressed():
	new_crew_rejected.emit(crew)
	self.visible = false	
