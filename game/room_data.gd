class_name RoomData
extends Node
#this class contains all the logic for a room's functionality
#compared to the Room class which is for the physical appearance of the room

#track whether the room is "cleared". the meaning of "cleared" is dependant on the type of room.
#(e.g., a room of enemies will be cleared when the enemies are killed, while the start room is cleared as soon as it is entered)
var room_cleared: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#contains the logic for when a room is entered
#this should be overriden in subclasses for non-generic logic
func on_enter_room() -> void:
	pass
	
#contains logic for when a room is "cleared"
#should be overriden, and called when cleared is set to true, if anything specific must happen when a room is cleared
#note that currently there is no logic to actually set a room as cleared, except for the spawn room, which automatically clears and does nothing. so.
func on_room_cleared() -> void:
	pass
	
