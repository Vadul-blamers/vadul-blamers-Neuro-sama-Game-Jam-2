extends Area2D

@export
var speed = 5000

var direction = Vector2()

func _on_Projectile_body_entered(body):
	if body.is_in_group("temp"):
		pass #change to damage calc

func _ready():
	look_at(get_local_mouse_position())
	
func _process(delta):
	move_local_y(speed*delta)
	pass
