extends RayCast3D
@onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = ""
	
	if is_colliding():
		var collider = get_collider()
		
		print("Colliding with " + collider.name + "...")
		label.text = "Colliding with " + collider.name + "..."
	else:
		print("Not colliding...")
		label.text = ""
