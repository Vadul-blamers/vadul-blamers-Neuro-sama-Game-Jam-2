extends CharacterBody2D
var cam_lock :bool = true
var mouse_location
var character_location
var facing = "down"
var mouse_relative_position
func _physics_process(_delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 300
	if cam_lock:
		_direction_facing(direction)
	else:
		mouse_location = get_global_mouse_position()
		character_location = global_position
		mouse_relative_position = mouse_location - character_location
		print(mouse_relative_position)
		_direction_facing(mouse_relative_position)
	if velocity == Vector2(0,0) :
		_idle_animations()
	else:
		_walking_animations()
	move_and_slide()

func _direction_facing(orientation):
	if abs(orientation.x) > abs(orientation.y):
		if orientation.x > 0:
			facing = "left"
		else:
			facing = "right"
	else:
		if orientation.y > 0:
			facing = "down"
		else:
			facing = "north"

func _walking_animations():
	match facing:
		"left":
			pass
		"up":
			pass
		"right":
			pass
		"down":
			$AnimatedSprite2D.play("Walking down")
		_:
			_idle_animations()

func _idle_animations():
	match $AnimatedSprite2D.animation:
		"Walking down":
			$AnimatedSprite2D.play("Idle down")
		"Walking up":
			pass
		"Walking right":
			pass
		"Walking left":
			pass
