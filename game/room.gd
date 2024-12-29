extends Node2D
class_name Room
#this class contains the physical appearance and triggers for a room
#compared to RoomData which contains the functionality of a room

#the types of rooms that a room can be set to
enum RoomTypes{
	SPAWN,
	ENEMY,
	END,
	EMPTY
}
#the room type that a room will be, set in the editor so that the same room base can be set to different rooms
@export var room_type: RoomTypes

#the data for the type of room this room is
var room_data: RoomData

#the map the room belongs to
var map: Map

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
		RoomTypes.END:
			room_data = EndRoomData.new()
		RoomTypes.EMPTY:
			room_data = EmptyRoomData.new()
	
#trigger logic for when the room is entered
func _entered_room() -> void:
	$Camera2D.make_current() #move camera to new room
	GameState.set_current_room(self)
	#map.current_room = self
	room_switched.emit(self)
	room_data.on_enter_room() #activate room switching logic

#if the room was entered and the room is not the room the player is currently in, trigger the room entry effects
#might want to separate this for the camera vs room entry effects 
func _on_room_interior_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and not GameState.get_current_room() == self:
		_entered_room()
		
#signal for when the room is swapped
signal room_switched(room: Room)
