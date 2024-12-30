extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.player.speed += 50
	queue_free()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
