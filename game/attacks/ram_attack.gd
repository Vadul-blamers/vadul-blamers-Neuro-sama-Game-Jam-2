extends RigidBody2D
var speed = 5000
var direction = Vector2()

func _on_Projectile_body_entered(body):
	if body.is_in_group("temp"):
		pass #change to damage calc

func _ready():
	if direction.length() > 0:
		direction = direction.normalized()
		apply_impulse(Vector2(), direction * speed)
