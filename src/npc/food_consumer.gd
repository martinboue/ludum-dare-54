class_name FoodConsumer
extends Timer


func _ready() -> void:
	timeout.connect(_on_timeout)

func _on_timeout() -> void:
	ResourceManager.consume_food()
	
