extends Control

@export
var save_file_path = "user://config.save"

@export
var turn_time = 30.0
@export
var turn_warning_time = 5.0

func _ready():
	$Label2.visible = !OS.is_userfs_persistent()
	pass

func _on_back_button_pressed() -> void:
	save()
	get_tree().change_scene_to_file("res://menu/main_menu.tscn")

func get_save():
	var data = {
		"turn_time": turn_time,
		"turn_warming_time" : turn_warning_time
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
	pass
