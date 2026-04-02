extends Node

var room_scene1: PackedScene = preload("res://chunks/roomEnter.tscn")
@export var room_scene2: PackedScene
@export var room_scene3: PackedScene
@export var room_scene4: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var room1 = roomSpawn(room_scene1, $Spawn.position, Vector3.BACK)
	var room2 = roomSpawn(room_scene2, room1.position, Vector3.BACK)
	var room3 = roomSpawn(room_scene3, room2.position, Vector3.BACK)
	var room4 = roomSpawn(room_scene2, room3.position, Vector3.LEFT)
	roomSpawn(room_scene3, room4.position, Vector3.FORWARD)
	
	roomSpawn(room_scene4, $Spawn.position, Vector3.RIGHT)
	roomSpawn(room_scene1, $Spawn.position, Vector3.FORWARD)

func roomSpawn(scene: PackedScene, connect_to: Vector3, side: Vector3):
	var room: Node3D = scene.instantiate()
	var x = side * 10
	add_child(room)
	room.look_at_from_position(connect_to + x, connect_to, Vector3.UP)
	
	return room

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
