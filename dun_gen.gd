extends Node3D
class_name DunGen

@export var grid_size : int = 5
@export var chunk_size : int = 10
# !insert all chunk scenes!
@export var chunks : Array[PackedScene] = []

var chunk_grid = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for x in range(grid_size):
		var row =  []
		for y in range(grid_size):
			row.append(0)
		chunk_grid.append(row)
	
	grid_debug()
	
	var spawn_chunks = get_children()
	for chunk in spawn_chunks:
		if chunk is Chunk:
			chunk_grid[chunk.coords.x][chunk.coords.y] = chunk
	
	grid_debug()

func grid_debug():
	var str = ""
	
	for x in range(chunk_grid.size()):
		for y in range(chunk_grid[x].size()):
			if chunk_grid[x][y] is not int:
				str += "C "
			else:
				if chunk_grid[x][y] == 0:
					str += "0 "
				else:
					str += "? "
		
		str += "r%d \n" % x
	
	print(str)

func get_neighbor_coords(coords : Vector2, dir):
	if ((coords.x - 1) > 0) or ((coords.x + 1) <= grid_size):
		print("gncoord OOB x")
	if ((coords.y - 1) > 0) or ((coords.y + 1) <= grid_size):
		print("gncoord OOB y")
	
	if dir == "front":
		return Vector2(coords.x, coords.y - 1)
	if dir == "back":
		return Vector2(coords.x, coords.y + 1)
	if dir == "left":
		return Vector2(coords.x - 1, coords.y)
	if dir == "right":
		return Vector2(coords.x + 1, coords.y)
	print("gnc failed. direction input likely invalid.")

func get_neighbor_chunk(coords : Vector2, dir):
	if ((coords.x - 1) < 0) or ((coords.x + 1) >= grid_size):
		print("gnchunk OOB x")
		return 0
	if ((coords.y - 1) < 0) or ((coords.y + 1) >= grid_size):
		print("gnchunk OOB y")
		return 0
	var neighbor = get_neighbor_coords(coords, dir)
	return chunk_grid[neighbor.x][neighbor.y]

func check_if_empty_coords(coords : Vector2) -> bool:
	if(coords.y < 0 or coords.x < 0):
		print("OOBs")
		return false

	if chunk_grid[coords.x][coords.y] is int:
		return true
	else:
		return false

func check_if_connectors_fit(chunk : Chunk, potential_coords : Vector2) -> Array: 
	var possible_turns : Array = []
	
	var surrounding_chunks : Dictionary = { 
		"front" : get_neighbor_chunk(chunk.get_coords(), "front"), 
		"right" : get_neighbor_chunk(chunk.get_coords(), "right"),
		"back" : get_neighbor_chunk(chunk.get_coords(), "back"),
		"left" : get_neighbor_chunk(chunk.get_coords(), "left")
		}
	
	var connections_to_match = []
	if surrounding_chunks["front"] == 0:
		connections_to_match.append(null) 
	else:
		var cons = surrounding_chunks["front"].get_connections()
		connections_to_match.append(cons["back"])
	if surrounding_chunks["right"] == 0:
		connections_to_match.append(null) 
	else:
		var cons = surrounding_chunks["right"].get_connections()
		connections_to_match.append(cons["left"])
	if surrounding_chunks["back"] == 0:
		connections_to_match.append(null) 
	else:
		var cons = surrounding_chunks["back"].get_connections()
		connections_to_match.append(cons["front"])
	if surrounding_chunks["left"] == 0:
		connections_to_match.append(null) 
	else:
		var cons = surrounding_chunks["left"].get_connections()
		connections_to_match.append(cons["right"])
	
	for turn in range(4):
		var are_matching = true
		
		#var current_connections : Dictionary[String, Connector] = chunk.get_connections()
		#if connections_to_match[0] == null:
			#if current_connections["front"] != null:
				#are_matching = false
		#if connections_to_match[1] == null:
			#if current_connections["right"] != null:
				#are_matching = false
		#if connections_to_match[2] == null:
			#if current_connections["back"] != null:
				#are_matching = false
		#if connections_to_match[3] == null:
			#if current_connections["left"] != null:
				#are_matching = false
		
		if are_matching: 
			possible_turns.append(turn)
		
		print(turn)
		chunk.increase_orientation()
	
	return possible_turns

func chunk_spawn(scene_index : int, coords : Vector2) -> bool:
	print("Scene index recieved: %d" % scene_index)
	
	var debug = chunks[scene_index].instantiate()
	print(debug)
	var chunk : Chunk = debug
	print(chunk)
	add_child(chunk)
	
	var rng = RandomNumberGenerator.new()
	var possible_turns : Array = check_if_connectors_fit(chunk, coords)
	if possible_turns.size() > 0:
		chunk_grid[coords.x][coords.y] = chunk
		chunk.set_coords(coords)
		
		var selection : int = rng.randi_range(0, possible_turns.size() - 1)
		chunk.set_orientation(possible_turns[selection])
		
		chunk.position = Vector3(coords.x*chunk_size, 0, coords.y*chunk_size)
		
		return true
	
	chunk.queue_free()
	return false
