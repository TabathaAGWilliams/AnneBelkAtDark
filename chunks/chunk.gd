extends Node3D
class_name Chunk

@export var coords : Vector2 = Vector2(0,0)
@export var orient : float 
@export var connections : Dictionary = {"front":0, "right":0, "back":0, "left":0}
@onready var dun_gen : DunGen = get_parent()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if orient != 0:
		var orientation_body = $orientation
		orientation_body.rotation_degrees = Vector3(0, orient, 0)
		
		var turns = orient / 90 
		for turn in turns:
			var dir = connections.keys()[0]
			var num = connections.values()[0]
			connections.erase(dir)
			connections[dir] = num

func get_coords() -> Vector2:
	return coords

func set_coords(new_coords : Vector2) :
	coords = new_coords

func get_connections() -> Dictionary:
	return connections

func connecter_called(scene_to_try : int, side_to_try_on : String) -> bool: 
	print(side_to_try_on + " door says hi")
	
	if scene_to_try < 0:
		print("Ran out of options")
		return true
	
	#connections.
	
	print(get_coords())
	print(side_to_try_on)
	var neighbor_coords = dun_gen.get_neighbor_coords(coords, side_to_try_on)
	print(neighbor_coords)
	
	if dun_gen.check_if_empty_coords(neighbor_coords):
		dun_gen.chunk_spawn(scene_to_try, neighbor_coords)
		dun_gen.grid_debug()
		return true
	
	return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
