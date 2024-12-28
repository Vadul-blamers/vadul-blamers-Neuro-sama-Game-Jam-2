extends Node

@export var positiveValue = 2.0;
var events : Events;

func choose_event(choices : Array[int]):
	var weights : Array[float] = [];
	weights.resize(choices.size());
	var history = events.getDamageHistory();
	var positive = 0.0;
	for c in choices:
		var e = events.getEvent(c)
		if (e.isPositive()):
			positive += 1.0;
	for i in choices.size():

		var choice = choices[i];
		var e = events.getEvent(choice)
		if (e.isPositive()):
			weights[i] = positiveValue * sqrt(positive);
		else:
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
