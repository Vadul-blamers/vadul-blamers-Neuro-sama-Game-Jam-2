class_name EndRoomData
extends RoomData

func on_enter_room() -> void:
	print("end room")
	if not room_cleared:
		pass #replace with enemy spawning logic later
		
func on_room_cleared() -> void:
	pass #replace with moving to next map logic later
