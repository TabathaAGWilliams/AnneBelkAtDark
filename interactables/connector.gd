extends Interactable
class_name Connector

# sides are "front", "right", "back", "left"

# index of scene in array : option's weight
@export var possible_scenes : Dictionary[int, float] = {}

func interact(body):
	var chunk : Chunk = get_parent().get_parent()
	var successful = false
	
	while not successful:
		var try_scene : int = weighted_dice()
		print("Trying scene: %d" % try_scene)
		successful = chunk.connecter_called(try_scene, self)
	
	queue_free()

func weighted_dice() -> int:
	var rng := RandomNumberGenerator.new()
	var i : int = rng.rand_weighted(possible_scenes.values())
	var scene_index : int = possible_scenes.keys()[i]
	possible_scenes.erase(possible_scenes.keys()[i])
	
	if possible_scenes.is_empty():
		return -1
	return scene_index
