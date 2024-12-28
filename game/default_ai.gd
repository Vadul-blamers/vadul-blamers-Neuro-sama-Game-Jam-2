extends Node

var events : Events;

func choose_event(choices : Array[int]):
	var weights = choices.duplicate();
	var history = events.getDamageHistory();
	for i in choices.size():
		var choice = choices[i];
		weights[i] = history[choice];
		weights[i] *= events.getEvent(choice).specialWeightFactor();
		# Maybe do some squaring or adding minimums or something here
	# Do weighted randomness to choose an action
	return choices[0]; #placeholder

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	events = get_node("/root/Events");


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
