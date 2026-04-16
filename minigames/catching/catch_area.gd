extends Area2D
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	print("CatchArea process mode: ", process_mode)
	
func _on_area_entered(area: Area2D) -> void:
	if area.has_signal("caught"):
		area.caught.emit()
		area.queue_free()
