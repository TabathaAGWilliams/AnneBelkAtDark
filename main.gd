extends Node

#var oldCam : Camera3D = get_viewport().get_camera_3d()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("reset"):
		get_tree().reload_current_scene()
	
	if event.is_action_pressed("2nd_camera"):
		if !$Camera3D.is_current():
			$Camera3D.make_current()
