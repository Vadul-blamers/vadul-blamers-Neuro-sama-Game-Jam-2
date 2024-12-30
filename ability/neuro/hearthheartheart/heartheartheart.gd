extends Node2D

var timer = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.player.health += 15
	if GameState.player.max_health < GameState.player.heatlh:
		GameState.player.health = GameState.player.max_health

func _process(delta):
	timer += delta
	if timer > 2:
		timer = 0
		queue_free()
