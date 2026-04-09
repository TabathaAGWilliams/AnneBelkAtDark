extends CanvasLayer


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#func _input(event):
	#Close the game if they press escape
	#if event.is_action_pressed("ui_cancel"):
		#close_minigame()

func close_minigame():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false
	queue_free()


func _on_button_pressed() -> void:
		close_minigame()
