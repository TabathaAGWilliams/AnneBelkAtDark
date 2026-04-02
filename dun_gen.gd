extends Node3D

@export var gridSize : int = 5
@export var chunkSize : int = 10



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var grid = []
	for i in range(gridSize):
		var row =  []
		for j in range(gridSize):
			row.append(0)
		grid.append(row)
	
	
	

func roomSpawn(scene: PackedScene, connect_to: Vector3, side: Vector3):
	var room: Node3D = scene.instantiate()
	var x = side * chunkSize
	add_child(room)
	room.look_at_from_position(connect_to + x, connect_to, Vector3.UP)
	
	return room

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
