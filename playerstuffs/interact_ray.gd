extends RayCast3D
@onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = ""
	
	if owner.is_frozen:
		return
	
	if is_colliding():
		var collider = get_collider()
		
		#checking to see if collider is an interactable
		if collider is Interactable:
			label.text = collider.prompt_message
			
			
			if Input.is_action_just_pressed("interact"):
				collider.interact(owner)
		else: 
			#print("Colliding with " + collider.name + "...")
			#label.text = "Colliding with " + collider.name + "..."
			
			label.text = ""
	else:
		#print("Not colliding...")
		label.text = ""
