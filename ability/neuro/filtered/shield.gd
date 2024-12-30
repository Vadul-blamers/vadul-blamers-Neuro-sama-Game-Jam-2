extends Node2D

var target_enemy

# Called when the node enters the scene tree for the first time.
func _ready():
	target_enemy = get_parent()
	if target_enemy.get("health") != null: target_enemy = null


func _process(delta):
	pass
