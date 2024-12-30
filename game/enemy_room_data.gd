class_name EnemyRoomData
extends RoomData

func _on_enter_room(room: Room) -> void:
	print("enemy room")
	if not room_cleared:
		pass
