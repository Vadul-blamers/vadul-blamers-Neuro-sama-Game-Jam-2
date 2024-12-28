class_name Map
extends Node2D

var current_room: Room

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#move the ui along with the camera position changes
#it's not ideal. but the ui isn't my job so. you can just delete this if it doesn't work for the ui.
#also, it's not actually moving the ui LULE. i don't know how to implement the ui so this is just a placeholder image.
func move_ui() -> void:
	$Placeholder.global_position.x = get_viewport().get_camera_2d().global_position.x
	$Placeholder.global_position.y = get_viewport().get_camera_2d().global_position.y - get_viewport().get_camera_2d().get_viewport_rect().size.y / 2 + 192 / 2
	pass
