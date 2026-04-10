extends CanvasLayer
@onready var game_holder = $GameContainer
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func launch_game(game_scene_path: String):
	var game_scene = load(game_scene_path)
	var game_instance = game_scene.instantiate()
	
	game_instance.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(game_instance)
	
	if game_instance.has_signal("game_finished"):
		game_instance.game_finished.connect(close_minigame)
	
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	#get_tree().paused = true # Optional: pause the main world behind the UI
func close_minigame():
	var player = get_tree().root.get_node("Node/CharacterBody3D")
	if player:
		player.enable()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false
	queue_free()


func _on_button_pressed() -> void:
		close_minigame()
