extends CharacterBody3D

@onready var camera = $Camera3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var camLock = true 
var camSens = 0.001
var camPitch = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event.is_action_pressed("camera"):
		if camLock:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		if !camLock: 
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		camLock = not camLock

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if camLock:
			camera.rotate_y(-event.relative.x * camSens)
			camPitch -= event.relative.y * camSens
			camPitch = clamp(camPitch, deg_to_rad(-80), deg_to_rad(80))
			camera.rotation.x = camPitch
			

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
