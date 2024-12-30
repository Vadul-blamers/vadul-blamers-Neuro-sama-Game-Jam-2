extends Node2D

@export var damage:int =1

var tracked = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	tracked.push_back(body)
	pass # Replace with function body.


func _on_area_2d_body_exited(body):
	tracked.erase(body)
	pass # Replace with function body.


func _on_timer_timeout():
	tracked.all(func(item):
		item.health -= damage + GameState.player.damage_modifier
		return true
		pass)
	pass # Replace with function body.
