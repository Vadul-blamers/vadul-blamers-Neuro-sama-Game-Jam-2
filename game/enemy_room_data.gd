class_name EnemyRoomData
extends RoomData

func on_enter_room() -> void:
	print("enemy room")
	if not room_cleared:
		pass #replace with enemy spawning logic later
