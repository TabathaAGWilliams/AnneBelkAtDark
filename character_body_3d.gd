extends CharacterBody3D

@onready var joint = $Neck
@onready var camera = $Neck/Eyes

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var camLock = true 
var camSens = 0.01
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
			camera.rotate_x(-event.relative.y * camSens)
			joint.rotate_y(-event.relative.x * camSens)

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
	var direction = (joint.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
