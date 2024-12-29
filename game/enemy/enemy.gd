extends CharacterBody2D

@export 
var movement_speed: float = 4.0
@onready 
var navigation_agent =$NavigationAgent2D

@export
var health = 2

var _active = false
func _ready():
	pass
	
func _physics_process(delta):
		
	if health <=0:
		_die()
	if !_active:
		return
	if GameState.player == null:
		return
	velocity = global_position.direction_to(GameState.player.global_position) * movement_speed
	move_and_slide()
	pass

func _on_timer_timeout():
	_active = true
	$CollisionShape2D.disabled = false
	pass # Replace with function body.

func _die():
	queue_free()
