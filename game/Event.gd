extends Node
class_name Event;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Make this return someting special if an event has something else impact its weight for the AI to pick.
# Should be 0 for antisynergy or large for synergy, or calculated if it's based on outside factors.
func specialWeightFactor():
	return 1;
