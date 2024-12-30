extends Node2D

@onready
var rect = $TextureRect
@onready
var timer =$Timer

func _ready():
	
	pass

func _process(delta):
	rect.material.set("shader/parameter/amt", timer.time_left)
	pass
