class_name Farmer
extends Npc


func _on_food_producter_timeout() -> void:
	ResourceManager.produce_food()
