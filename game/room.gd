extends Node2D
class_name Room
#this class contains the physical appearance and triggers for a room
#compared to RoomData which contains the functionality of a room
#LULE nvm this class does both

static var total_enemies = 0

#the types of rooms that a room can be set to
enum RoomTypes{
	SPAWN,
	ENEMY,
	END,
	EMPTY
}
#the room type that a room will be, set in the editor so that the same room base can be set to different rooms
@export var room_type: RoomTypes

#the data for the type of room this room is
var room_data: RoomData

#set up the room 
func _ready() -> void:
	
	#depending on the room type set to each room, initialize the room data
	match room_type:
		RoomTypes.SPAWN:
			room_data = SpawnRoomData.new()
			_entered_room()
		RoomTypes.ENEMY:
			room_data = EnemyRoomData.new()
		RoomTypes.END:
			room_data = EndRoomData.new()
		RoomTypes.EMPTY:
			room_data = EmptyRoomData.new()
	
var enemy_effect = preload("res://ability/neuro/more-neuros/effect.tscn")
#trigger logic for when the room is entered
func _entered_room() -> void:
	$Camera2D.make_current() #move camera to new room
	GameState.set_current_room(self)
	room_switched.emit(self)
	_spawn_enemies()
	room_data.on_enter_room() #activate room switching logic
	if room_data is EmptyRoomData:
		var i = EmptyRoomData.get_music_heard()
		get_parent().change_music(i)
		
func _spawn_enemies() -> void:
	if room_data is SpawnRoomData or room_data is EmptyRoomData:
		return
	if room_data.room_cleared:
		return
	var inc = 0
	if room_data is EndRoomData:
		inc += 3
	for i in range(2 + inc):
		var x = randi_range(self.global_position.x + 128, self.global_position.x + 1280 - 128)
		var y = randi_range(self.global_position.y + 300, self.global_position.y + 736 - 128)
		var position = Vector2(x, y)
		var effect = enemy_effect.instantiate()
		effect.tree_entered.connect(func():
			effect.position = position
			pass)
		get_parent().add_child(effect)
		Room.total_enemies += 5
	lock_room()

#if the room was entered and the room is not the room the player is currently in, trigger the room entry effects
#might want to separate this for the camera vs room entry effects 
func _on_room_interior_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and not GameState.get_current_room() == self:
		_entered_room()
		
#signal for when the room is swapped
signal room_switched(room: Room)

static func room_is_locked() -> bool:
	return total_enemies > 3

func lock_room() -> void:
	$RoomExits.enabled = true
	$CanLeaveRoom.start()
	pass

func _on_can_leave_room_timeout() -> void:
	if not Room.room_is_locked():
		$RoomExits.enabled = false
		$CanLeaveRoom.stop()
		Room.total_enemies = 0
		room_data.room_cleared = true
		if room_data is EndRoomData:
			get_tree().change_scene_to_file("res://game/ending_lore.tscn")
