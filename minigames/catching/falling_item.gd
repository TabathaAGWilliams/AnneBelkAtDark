extends Area2D

signal caught  # This "shouts" when the item is caught

@export var fall_speed: float = 300.0

func _process(delta: float) -> void:
	# Move downward
	position.y += fall_speed * delta
	
	# If the player misses, delete it when it's off-screen
	if position.y > 600:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	# This is the logic we discussed earlier!
	# It checks if the area it hit is the Bucket's "catchArea"
	if area.name == "catchArea":
		caught.emit()  # Tell the game we were caught
		queue_free()   # Disappear
