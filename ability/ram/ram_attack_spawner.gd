extends Node2D

@onready
var timer = $Timer

var projectile = preload("res://ability/ram/projectile.tscn")
var can_fire = true

# Called when the node enters the scene tree for the first time.
func _ready():
	reparent(GameState.player)
	pass # Replace with function body.

func _input(event):
	if can_fire && event.is_action_pressed("attack"):
		var instance = projectile.instantiate()
		can_fire = false
		instance.tree_entered.connect(func():
			instance.position = GameState.player.position
			pass)
		#this code is just here so we can test on the player scene alone.
		if GameState.entity_container == null:
			get_tree().root.add_child(instance)
		else:
			GameState.entity_container.add_child(instance)
		timer.start(1)
		pass
	pass

func _on_timer_timeout():
	can_fire = true
	pass
