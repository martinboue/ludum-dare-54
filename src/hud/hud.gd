extends CanvasLayer

@onready var population: Label = $RightContainer/Population/Label
@onready var food: Label = $RightContainer/Food/Label
@onready var day: Label = $LeftContainer/Day/Label

func _process(delta: float) -> void:
	population.text = str(ResourceManager.get_npc_count())
	food.text = str(ResourceManager.get_food_count())
	day.text = str(ResourceManager.get_day_count())
