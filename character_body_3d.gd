#notes: https://www.youtube.com/watch?v=RV-Nwy8N68o
extends CharacterBody3D

@export var SPEED = 5.0
@export var JUMP_VELOCITY = 4.5
@export var cam_sens : float = 0.2
@export var cam_min_rot = -80
@export var cam_max_rot = 90

@onready var head = $Head
var cam_lock : bool = true 
var cam_look_rot : Vector2
var is_frozen = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event.is_action_pressed("camera"):
		if cam_lock:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		if !cam_lock: 
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		cam_lock = not cam_lock
		
	if event is InputEventMouseMotion:
		if cam_lock:
			cam_look_rot.y -= (event.relative.x * cam_sens)
			cam_look_rot.x -= (event.relative.y * cam_sens)
			cam_look_rot.x = clamp(cam_look_rot.x, cam_min_rot, cam_max_rot)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	head.rotation_degrees.x = cam_look_rot.x
	rotation_degrees.y = cam_look_rot.y


func disable():
	is_frozen = true
	set_physics_process(false)
	set_process_input(false)

func enable():
	is_frozen = false
	set_physics_process(true)
	set_process_input(true)
