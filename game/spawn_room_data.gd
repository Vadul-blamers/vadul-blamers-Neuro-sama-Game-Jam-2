extends RoomData


func on_enter_room() -> void:
	if not room_cleared:
		room_cleared = true
