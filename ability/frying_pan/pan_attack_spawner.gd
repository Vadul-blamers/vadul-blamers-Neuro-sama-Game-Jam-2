extends Node2D

@onready
var timer = $Timer

var projectile = preload("res://ability/frying_pan/pan-projectile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_parent() != GameState.player:
		reparent(GameState.player)
	timer.start(4)
	pass # Replace with function body.

func _on_timer_timeout():
	timer.start(4)
	var instance = projectile.instantiate()
	instance.tree_entered.connect(func():
		instance.position = GameState.player.position
		pass)
		#this code is just here so we can test on the player scene alone.
	if GameState.entity_container == null:
		get_tree().root.add_child(instance)
	else:
		GameState.entity_container.add_child(instance)
		
	
	pass
