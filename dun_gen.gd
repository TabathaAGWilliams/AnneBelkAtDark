extends Node3D
class_name DunGen

@export var grid_size : int = 5
@export var chunk_size : int = 10
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
	#print("gnc start...")
	if dir == "front":
		return Vector2(coords.x, coords.y - 1)
	if dir == "back":
		return Vector2(coords.x, coords.y + 1)
	if dir == "left":
		return Vector2(coords.x - 1, coords.y)
	if dir == "right":
		return Vector2(coords.x + 1, coords.y)
	print("gnc failed. direction input likely invalid.")

func check_if_empty_coords(coords : Vector2) -> bool:
	if(coords.y < 0 or coords.x < 0):
		print("OOBs")

	if chunk_grid[coords.x][coords.y] is int:
		return true
	else:
		return false

func chunk_spawn(scene_index : int, coords : Vector2):
	print("Scene index recieved: %d" % scene_index)
	var chunk : Node3D = chunks[scene_index].instantiate()
	print(chunk)
	add_child(chunk)
	
	chunk.set_coords(coords)
	chunk.position = Vector3(coords.x*chunk_size, 0, coords.y*chunk_size)
	chunk_grid[coords.x][coords.y] = chunk
