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
	process_mode = PROCESS_MODE_ALWAYS
	score = 0
	
	if not game_timer.timeout.is_connected(_on_game_timer_timeout):
		game_timer.timeout.connect(_on_game_timer_timeout)

	game_timer.start()
	print("Minigame Started! Goal: ", win_score)

func _on_game_timer_timeout() -> void:
	spawner.spawn_item(self)

func add_score() -> void:
	score += 1
	print("Score: ", score)

	if score >= win_score:
		PlayerStats.points_added(10)
		complete_game()

func _on_minigame_won() -> void:
	PlayerStats.points_added(10)
	
func complete_game() -> void:
	game_timer.stop()
	print("Minigame Won!")
	game_finished.emit()
