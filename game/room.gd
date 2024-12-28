extends Node2D
class_name Room
#this class contains the physical appearance and triggers for a room
#compared to RoomData which contains the functionality of a room

#the types of rooms that a room can be set to
enum RoomTypes{
	SPAWN,
	ENEMY
}
#the room type that a room will be, set in the editor so that the same room base can be set to different rooms
@export var room_type: RoomTypes

#the data for the type of room this room is
var room_data: RoomData

#the map the room belongs to
var map: Map

#variables for if the room has rooms to each direction of it
#@export var room_to_north:= false
#@export var room_to_east:= false
#@export var room_to_south:= false
#@export var room_to_west:= false

#do transitions based on hitting a certain point in a room you are NOT currently in?
#avoids the issue of switching rooms too early

#set up the room 
func _ready() -> void:
	#set the map variable to the current map
	map = get_parent()
	
	#depending on the room type set to each room, initialize the room data
	match room_type:
		RoomTypes.SPAWN:
			room_data = SpawnRoomData.new()
			_entered_room()
		RoomTypes.ENEMY:
			room_data = EnemyRoomData.new()
	
#check to see if the player did in fact enter the room
func _entered_room() -> void:
	
	#pseudocode -- if player collides with room transition and map.current_room is not this room: 
	$Camera2D.make_current() #move camera to new room
	room_data.on_enter_room() #activate room switching logic

#if the room was entered and the room is not the room the player is currently in, trigger the room entry effects
#might want to separate this for the camera vs room entry effects 
func _on_room_interior_area_entered(area: Area2D) -> void:
	if not map.current_room == self:
		_entered_room()
