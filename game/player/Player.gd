extends CharacterBody2D

@export
var speed:float = 300.0
@export
var health = 30.0

var cam_lock :bool = true
var mouse_location
var character_location
var facing = "down"
var mouse_relative_position
var ram_attack_scene : PackedScene = preload("res://game/attacks/ram_attack.tscn")
var attack_cooldown = 5
var attack_timer = 0

func _ready():
	GameState.player = self

func _physics_process(_delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	attack_timer += _delta
	mouse_location = get_global_mouse_position()
	character_location = global_position
	mouse_relative_position = mouse_location - character_location
	print(global_position)
	if cam_lock:
		_direction_facing(direction)
	else:
		_direction_facing(mouse_relative_position)
	if velocity == Vector2(0,0) :
		_idle_animations()
	else:
		_walking_animations()
	move_and_slide()
	if attack_timer > attack_cooldown:
		attack_timer = 0
		fire_RAM()



func _direction_facing(orientation):
	if abs(orientation.x) > abs(orientation.y):
		if orientation.x > 0:
			facing = "right"
		else:
			facing = "left"
	else:
		if orientation.y > 0:
			facing = "down"
		else:
			facing = "up"

func _walking_animations():
	match facing:
		"left":
			$AnimatedSprite2D.play("Walking left")
		"up":
			$AnimatedSprite2D.play("Walking up")
		"right":
			$AnimatedSprite2D.play("Walking right")
		"down":
			$AnimatedSprite2D.play("Walking down")
		_:
			_idle_animations()

func _idle_animations():
	match $AnimatedSprite2D.animation:
		"Walking down":
			$AnimatedSprite2D.play("Idle down")
		"Walking up":
			$AnimatedSprite2D.play("Idle up")
		"Walking right":
			$AnimatedSprite2D.play("Idle right")
		"Walking left":
			$AnimatedSprite2D.play("Idle left")

func fire_RAM():
	if ram_attack_scene:
		var RAM_Projectile = ram_attack_scene.instantiate()
		RAM_Projectile.position = global_position + (mouse_relative_position.normalized()*50)
		RAM_Projectile.direction = mouse_relative_position.normalized()
		get_tree().root.add_child(RAM_Projectile)
