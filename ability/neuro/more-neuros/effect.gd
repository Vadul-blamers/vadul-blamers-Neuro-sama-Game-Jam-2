extends Node2D

func _ready():
	get_children().all(func(child:Node):
		child.reparent(get_parent(),true)
		return true
		pass)
	queue_free()
	pass # Replace with function body.
