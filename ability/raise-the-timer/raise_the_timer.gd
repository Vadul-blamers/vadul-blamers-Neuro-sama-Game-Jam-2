extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.ai_control.turn_time += 5
	queue_free()
	pass
