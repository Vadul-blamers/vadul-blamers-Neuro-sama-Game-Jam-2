class_name EmptyRoomData
extends RoomData

func on_enter_room() -> void:
	print("empty room")
	if not room_cleared:
		room_cleared = true
