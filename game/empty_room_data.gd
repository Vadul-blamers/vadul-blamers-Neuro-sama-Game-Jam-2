class_name EmptyRoomData
extends RoomData

static var music_heard = 0

static func get_music_heard() -> int:
	return music_heard
		

func on_enter_room() -> void:
	print("empty room")
	if not room_cleared:
		music_heard += 1
		room_cleared = true
