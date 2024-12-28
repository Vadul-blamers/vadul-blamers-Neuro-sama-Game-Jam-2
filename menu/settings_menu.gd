extends Control

@export
var save_file_path = "user://config.save"

@onready
var turn_time_field = $Container/VBoxContainer/HBoxContainer/TurnTime

@onready
var turn_warning_time_field = $Container/VBoxContainer/HBoxContainer2/TurnWarningTime

func _ready():
	var persistent = OS.is_userfs_persistent()
	$Label2.visible = !persistent
	if persistent:
		load_save()
		turn_time_field.text = str(Config.turn_time)
		turn_warning_time_field.text = str(Config.turn_warning_time)
	pass

func _on_back_button_pressed() -> void:
	var persistent = OS.is_userfs_persistent()
	if persistent:
		save()
	get_tree().change_scene_to_file("res://menu/main_menu.tscn")

func get_save():
	var data = {
		"turn_time": Config.turn_time,
		"turn_warning_time" : Config.turn_warning_time
	}
	return data
	
func save():
	var data = get_save()
	var save_file = FileAccess.open(save_file_path, FileAccess.WRITE)
	var json_string = JSON.stringify(data)
	save_file.store_line(json_string)
	pass

func load_save():
	var save_file = FileAccess.open(save_file_path, FileAccess.READ)
	if save_file == null:
		return
	var text = save_file.get_as_text()
	var data = JSON.parse_string(text)
	Config.turn_time = int(data["turn_time"])
	Config.turn_warning_time = int(data["turn_warning_time"])
	pass
