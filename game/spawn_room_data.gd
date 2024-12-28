extends RoomData
class_name SpawnRoomData

func on_enter_room() -> void:
	print("spawn room")
	if not room_cleared:
		room_cleared = true
