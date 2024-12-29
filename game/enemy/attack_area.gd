extends Area2D

@export
var attack = 1

var colliding = true

func _on_body_exited(body):
	if body == GameState.player:
		colliding = false
	pass # Replace with function body.

func _on_body_entered(body):
	if body == GameState.player:
		colliding = true


func _on_timer_timeout():
	if colliding:
		GameState.player.health -= attack
		pass
