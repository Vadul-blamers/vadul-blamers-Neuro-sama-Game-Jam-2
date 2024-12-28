class_name SpawnRoomData
extends RoomData

func on_enter_room() -> void:
	print("spawn room")
	if not room_cleared:
		room_cleared = true
