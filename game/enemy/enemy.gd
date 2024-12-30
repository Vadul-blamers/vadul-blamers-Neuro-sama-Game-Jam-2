extends CharacterBody2D

signal health_changed(from:int,to:int)
signal died()

@export 
var movement_speed: float = 4.0
@onready 
var navigation_agent =$NavigationAgent2D

@export
var health = 2:
	set(value):
		var old = health
		health = value
		health_changed.emit(old,health)

var _active = false
func _ready():
	pass
	
func _physics_process(delta):
	if health <= 0:
		_die()
	if !_active:
		return
	if GameState.player == null:
		return
	velocity = global_position.direction_to(GameState.player.global_position) * movement_speed
	move_and_slide()
	_animation(velocity)
	check_if_touching_player()
	pass

func _on_timer_timeout():
	_active = true
	$CollisionShape2D.disabled = false
	pass # Replace with function body.

func _die():
	died.emit()
	if Room.total_enemies > 0:
		Room.total_enemies -= 1
	queue_free()

func _animation(velocity):
	if abs(velocity.x) > abs(velocity.y):
		if velocity.x > 0:
			$AnimatedSprite2D.play("Walking right")
		else:
			$AnimatedSprite2D.play("Walking left")
	elif abs(velocity.x) < abs(velocity.y):
		if velocity.y > 0:
			$AnimatedSprite2D.play("Walking down")
		else:
			$AnimatedSprite2D.play("Walking up")
	else:
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

func check_if_touching_player():
	if global_position.x > GameState.player.global_position.x - 45:
		if global_position.x < GameState.player.global_position.x + 45:
			if global_position.y > GameState.player.global_position.y - 45:
				if global_position.y < GameState.player.global_position.y + 45:
					GameState.player.take_damage()
