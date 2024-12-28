extends CharacterBody2D

@export 
var movement_speed: float = 4.0
@onready 
var navigation_agent =$NavigationAgent2D

func _ready():
	pass
	
func _physics_process(delta):
	if GameState.player == null:
		return
	velocity = global_position.direction_to(GameState.player.global_position) * movement_speed
	move_and_slide()
	pass
