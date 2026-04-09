extends CanvasLayer
@onready var game_holder = $GameContainer

func launch_game(game_scene_path: String):
	# 1. Load the catching game file
	var game_scene = load(game_scene_path)
	var game_instance = game_scene.instantiate()
	
	# 2. Put it inside our holder node
	game_holder.add_child(game_instance)
	
	# 3. CONNECTION #4: Listen for the game to say "I'm done!"
	if game_instance.has_signal("game_finished"):
		game_instance.game_finished.connect(close_minigame)
	
	# 4. UI Setup
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true # Optional: pause the main world behind the UI
func close_minigame():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false
	queue_free()


func _on_button_pressed() -> void:
		close_minigame()
