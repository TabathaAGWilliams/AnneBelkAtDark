extends Node2D

# This is the slot where you drag your FallingItem.tscn in the Inspector
@export var item_scene: PackedScene 

# How wide the area is where items can drop (adjust to fit your screen)
@export var spawn_width: float = 500.0 

func spawn_item(game_root: Node) -> void:
	# 1. Safety check: make sure a scene is actually assigned
	if not item_scene:
		print("Error: No item_scene assigned to the Spawner!")
		return
	
	# 2. Create an instance of the item
	var item = item_scene.instantiate()
	
	# 3. Add it as a child of the spawner
	add_child(item)
	
	# 4. Set a random horizontal position
	# We use -width/2 to +width/2 so it's centered on the Spawner's position
	var random_x = randf_range(-spawn_width / 2, spawn_width / 2)
	item.position = Vector2(random_x, 0)
	
	# 5. Connect the item's 'caught' signal to the main game's scoring function
	# This ensures that when THIS specific item is caught, it adds a point.
	if item.has_signal("caught"):
		item.caught.connect(game_root.add_score)
