extends Node2D
class_name Room
#this class contains the physical appearance and triggers for a room
#compared to RoomData which contains the functionality of a room

#the data for the type of room this room is
@export var room_data: RoomData

#variables for if the room has rooms to each direction of it
@export var room_to_north:= false
@export var room_to_east:= false
@export var room_to_south:= false
@export var room_to_west:= false

#do transitions based on hitting a certain point in a room you are NOT currently in?
#avoids the issue of switching rooms too early

#for all the directions that do not have rooms in that direction, add the walls back and create collision
func _ready() -> void:
	if not room_to_north:
		$NorthWall/Wall.visible = true
		$NorthWall/BlockCollision/CollisionShape2D.set_deferred("disabled", false)
	if not room_to_east:
		$EastWall/Wall.visible = true
		$EastWall/BlockCollision/CollisionShape2D.set_deferred("disabled", false)
	if not room_to_south:
		$SouthWall/Wall.visible = true
		$SouthWall/BlockCollision/CollisionShape2D.set_deferred("disabled", false)
	if not room_to_west:
		$WestWall/Wall.visible = true
		$WestWall/BlockCollision/CollisionShape2D.set_deferred("disabled", false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
#check to see if the player did in fact enter the room
func _entered_room() -> void:
	
	#pseudocode -- if player collides with room transition and map.current_room is not this room: 
	if true:
		$Camera2D.make_current() #move camera to new room
		room_data.on_enter_room() #activate room switching logic
	pass
