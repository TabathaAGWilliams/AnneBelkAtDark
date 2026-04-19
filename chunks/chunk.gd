extends Node3D
class_name Chunk

# !whole numbers only!
@export var coords : Vector2 = Vector2(0,0)
# !don't rotate body, use this to change orientation!
@export var turns_right : int 
# !0 = no connection, 1 = door!
# !only assign present connectors; use "front", "right", "back", or "left"!
@export var connections : Dictionary[String, Connector] = {}

@onready var dun_gen : DunGen = get_parent()
@onready var orientation_body : Node3D = $orientation
var def_connections : Dictionary[String, Connector]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if connections.get("front") ==  null:
		connections["front"] = null
	if connections.get("right") ==  null:
		connections["right"] = null
	if connections.get("back") ==  null:
		connections["back"] = null
	if connections.get("left") ==  null:
		connections["left"] = null
	
	if turns_right != 0:
		for i in range(turns_right):
			increase_orientation()
	
	def_connections = connections.duplicate(false)

func get_coords() -> Vector2:
	return coords

func set_coords(new_coords : Vector2):
	coords = new_coords

func get_connections() -> Dictionary:
	return connections

func increase_orientation():
	print(orientation_body.get_rotation_degrees())
	var new_orient : Vector3 = orientation_body.get_rotation_degrees() + Vector3(0, 90, 0)
	orientation_body.set_rotation_degrees(new_orient)
	
	var start : Connector = connections["front"]
	connections["front"] = connections["right"]
	connections["right"] = connections["back"]
	connections["back"] = connections["left"]
	connections["left"] = start	

func set_orientation(turns : int):
	orientation_body.set_rotation_degrees(Vector3(0, 0, 0))
	connections = def_connections.duplicate(false)
	
	for turn in range(turns):
		increase_orientation()

func connecter_called(scene_to_try : int, connector : Connector) -> bool: 
	var side_to_try_on = connections.find_key(connector)
	print(side_to_try_on)
	
	if scene_to_try < 0:
		print("Ran out of options")
		return true
	
	print(get_coords())
	var neighbor_coords = dun_gen.get_neighbor_coords(coords, side_to_try_on)
	print(neighbor_coords)
	
	if dun_gen.check_if_empty_coords(neighbor_coords):
		dun_gen.chunk_spawn(scene_to_try, neighbor_coords)
		dun_gen.grid_debug()
		return true
	
	return false
