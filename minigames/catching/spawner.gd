extends Node2D
@export var item_scene: PackedScene 
@export var spawn_width: float = 700.0
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func spawn_item(game_root: Node) -> void:
	if not item_scene:
		print("Error: No item_scene assigned to the Spawner!")
		return
	
	var item = item_scene.instantiate()
	
	add_child(item)
	
	var random_x = randf_range( 50, spawn_width)
	item.position = Vector2(random_x, 0)
	
	if item.has_signal("caught"):
		item.caught.connect(game_root.add_score)
