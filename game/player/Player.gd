extends CharacterBody2D

@export
var speed:float = 300.0
@export
var health = 30.0
@export
var damage_modifier = 0
@export
var items:Array[AbilityContainer] = [
	preload("res://ability/ram/ram.tres")
]

@onready
var item_container = $CanvasLayer/Panel/MarginContainer/itemContainer

var cam_lock :bool = true
var mouse_location
var character_location
var facing = "down"
var mouse_relative_position

func _ready():
	GameState.player = self
	items.all(func(item:AbilityContainer):
		add_child(item.on_use.instantiate())
		item_container.add_child(item.icon.instantiate())
		pass)

func _physics_process(_delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	mouse_location = get_global_mouse_position()
	character_location = global_position
	mouse_relative_position = mouse_location - character_location
	if cam_lock:
		_direction_facing(direction)
	else:
		_direction_facing(mouse_relative_position)
	if velocity == Vector2(0,0) :
		_idle_animations()
	else:
		_walking_animations()
	move_and_slide()



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
