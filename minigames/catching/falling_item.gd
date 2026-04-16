extends Area2D

signal caught  

@export var fall_speed: float = 300.0
func _ready() -> void:
	#body_entered.connect(_on_area_entered)
	process_mode = Node.PROCESS_MODE_ALWAYS
func _process(delta: float) -> void:
	position.y += fall_speed * delta
	
	if position.y > 600:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.name == "CatchArea":
		caught.emit()  # Tell the game we were caught
		queue_free()   # Disappear
