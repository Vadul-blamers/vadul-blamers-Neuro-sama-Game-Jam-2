extends Node

@export var positiveValue = 1.5;
var events : AI_Control;

signal made_selection(selected:int)

var current_selection:Array[AbilityContainer] = []

func _on_selections_available(options:Array[AbilityContainer]):
	current_selection = options
	pass

func _on_turn_start():
	pass

func _on_turn_about_to_end():
	var selected = chooseEvent(current_selection);
	made_selection.emit(selected)

func _on_turn_end():
	current_selection = []
	
	
func chooseEvent(choices : Array[AbilityContainer]):
	var list = events.available_abilities;
	
	var ids : Array[float] = [];
	ids.resize(choices.size());	
	for i in choices.size():
		ids[i]= list.find(choices[i]);
	
	var weights : Array[float] = [];
	weights.resize(choices.size());
	var history = events.damageHistory;
	var positive = 0.0;
	for c in choices:
		if (c.isPositive()):
			positive += 1.0;
	for i in choices.size():

		var id = ids[i];
		var e = choices[i];
		if (e.isPositive()):
			weights[i] = positiveValue * sqrt(positive);
			
		else:
			weights[i] = history[id];
			weights[i] *= e.specialWeightFactor();
		# Maybe do some squaring or adding minimums or something here
	return choices[weightedRandom(weights)];
	
func weightedRandom(weights : Array[float]):
	var accumulated = weights.duplicate();
	var total = 0.0;
	for i in weights.size():
		total += weights[i];
		accumulated[i] = total;
	var rng = randf_range(0.0, total);
	for i in weights.size():
		if rng >= accumulated[i]:
			return i;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	events = get_node("/root/ai-control");


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
