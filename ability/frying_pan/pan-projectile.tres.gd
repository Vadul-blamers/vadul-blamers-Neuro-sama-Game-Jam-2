extends Area2D

@export
var speed = 5000
@export
var damage = 1
	
func _ready():
	var enemies  = get_tree().get_nodes_in_group("enemy")
	if enemies.is_empty():
		return
		
	var target = enemies[0]
	var player = GameState.player.global_position
	var target_distance = player.distance_to(target.global_position)
	#find the closest enemy to target
	for enemy in enemies:
		if player.distance_to(enemy.global_position) < target_distance:
			target_distance = player.distance_to(enemy.global_position)
			target = enemy
			pass
	look_at(target.global_position)

func _process(delta):
	move_local_x(delta*speed)
	
func _on_timer_timeout():
	queue_free()
	pass # Replace with function body.

func _on_body_entered(body):
	body.health -= damage
	pass # Replace with function body.
