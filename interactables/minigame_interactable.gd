extends Interactable

@export var minigame_ui_scene: PackedScene
@export_file("*.tscn") var game_to_load: String
func interact(body):
	if minigame_ui_scene:
		var ui_instance = minigame_ui_scene.instantiate()
		
		get_tree().root.add_child(ui_instance)
		
		if ui_instance.has_method("launch_game"):
			ui_instance.launch_game(game_to_load)
			
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
		get_tree().paused = true
	else:
		print("Error: No UI scene has been assigned to this minigame object!")
