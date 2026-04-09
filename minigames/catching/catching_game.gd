extends Node2D

# Signal to tell mini_game_ui.gd that the game is over
signal game_finished

@export var win_score: int = 10
var score: int = 0

# References to your specific nodes
@onready var spawner = $Spawner
@onready var game_timer = $GameTimer
@onready var bucket = $Bucket

func _ready() -> void:
	# 1. Reset score
	score = 0
	
	# 2. Make sure the timer is connected to the spawn logic
	# If you haven't connected this in the editor, we do it here:
	if not game_timer.timeout.is_connected(_on_game_timer_timeout):
		game_timer.timeout.connect(_on_game_timer_timeout)
	
	# 3. Start the game
	game_timer.start()
	print("Minigame Started! Goal: ", win_score)

func _on_game_timer_timeout() -> void:
	# Tell the spawner to create an item
	# We pass 'self' so the item can connect its signal back to this script
	spawner.spawn_item(self)

func add_score() -> void:
	score += 1
	print("Score: ", score)
	
	# Check for win condition
	if score >= win_score:
		complete_game()

func complete_game() -> void:
	# Stop everything
	game_timer.stop()
	print("Minigame Won!")
	
	# Emit the signal that mini_game_ui.gd is waiting for
	game_finished.emit()
