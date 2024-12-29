extends Node

var player: Node2D

static var current_room: Room

static func set_current_room(room: Room) -> void:
	current_room = room

static func get_current_room() -> Room:
	return current_room
