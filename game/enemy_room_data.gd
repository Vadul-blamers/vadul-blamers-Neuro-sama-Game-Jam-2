extends RoomData
class_name EnemyRoomData

func on_enter_room() -> void:
	print("enemy room")
	if not room_cleared:
		pass #replace with enemy spawning logic later
