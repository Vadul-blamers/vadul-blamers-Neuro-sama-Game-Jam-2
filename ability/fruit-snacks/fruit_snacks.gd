extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.player.movement_speed += 10
	#logic to make it display as an actual item for the player.
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
