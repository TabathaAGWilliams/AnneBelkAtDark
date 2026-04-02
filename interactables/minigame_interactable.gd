extends "res://interactables/interactable.gd"

@export var minigame_ui_scene: PackedScene

func interact(body):
	if minigame_ui_scene:
		var ui_instance = minigame_ui_scene.instantiate()
		
		get_tree().root.add_child(ui_instance)
		
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
		get_tree().paused = true
	else:
		print("Error: No UI scene has been assigned to this minigame object!")
