extends Node

signal made_selection(selected:int)

var current_selection:Array[AbilityContainer] = []

func _on_selections_available(options:Array[AbilityContainer]):
	current_selection = options
	pass

func _on_turn_start():
	pass

func _on_turn_about_to_end():
	var selected = randi_range(0,current_selection.size()-1)
	made_selection.emit(selected)

func _on_turn_end():
	current_selection = []
