class_name EnemyShielder
extends Unit


func _on_hurt_box_hurt() -> void:
	$HitPlayer.play()
