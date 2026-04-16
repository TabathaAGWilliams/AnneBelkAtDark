extends CharacterBody2D

const SPEED = 600.0
@export var left_limit: int = 50 
@export var right_limit: int = 1102

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func _physics_process(_delta: float) -> void:
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	position.x = clamp(position.x, left_limit, right_limit)
