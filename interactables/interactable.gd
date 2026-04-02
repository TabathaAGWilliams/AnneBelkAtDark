extends CollisionObject3D
class_name Interactable

@export var prompt_message = "interact"

func interact(body):
	print(body.name, " interacted with ", name)
