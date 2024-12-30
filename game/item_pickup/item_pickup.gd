extends Area2D

@export
var item:AbilityContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	$Node2D.add_child(item.icon.instantiate())
	pass # Replace with function body.

func _on_body_entered(body):
	GameState.player.add_item(item)
	queue_free()
	pass 
