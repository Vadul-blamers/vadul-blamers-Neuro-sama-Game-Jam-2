# this scene uses several timer nodes so the signals can be hooked up from 
# the UI without needing any conditional logic to figure what is being measured

extends Control

@export 
var turn_timer:Timer
@export 
var turn_about_to_end_timer:Timer
@export 
var card_selection_finished_timer:Timer

@export 
var turn_time = 30
@export
var turn_warning_time = 5
@export
var timer_color:Color
@export
var timer_warning_color:Color

@export
var animation_duration = 2.0

@export
var available_abilities: Array[AbilityContainer]

@onready
var _timer_bar = $MainContainer/VBoxContainer/TimerContainer/TimerBar
@onready
var _ability_grid = $MainContainer/VBoxContainer/Panel/AbilityGrid

var ability_cards:Array[AbilityCard] = []
var selected_ability:AbilityContainer = null

signal turn_about_to_end
signal turn_end
signal turn_start
signal options_generated(options:Array[AbilityContainer])
signal option_selected(ability:AbilityContainer)

# Called when the node enters the scene tree for the first time.
func _ready():
	turn_timer.timeout.connect(func():
		turn_about_to_end_timer.start(turn_warning_time)
		pass)
	turn_timer.start(turn_time-turn_warning_time)
	_generate_ability_roster()
	_timer_bar.max_value = turn_time+turn_warning_time
	_ability_grid.get_children().all(func(item:Node):
		ability_cards.push_back(item as AbilityCard)
		return true
	)
	pass

func _process(delta):
	if not turn_timer.is_stopped():
		_timer_bar.set_value_no_signal(turn_timer.time_left+turn_warning_time)
		pass
	else:
		_timer_bar.set_value_no_signal(turn_about_to_end_timer.time_left)
		pass
	pass

func _on_turn_wait_timer_timeout():
	turn_about_to_end.emit()
	_timer_bar.tint_progress = timer_warning_color
	pass

func _on_turn_about_to_end_timer_timeout():
	turn_end.emit()
	card_selection_finished_timer.start(2)
	_timer_bar.tint_progress = timer_color
	if selected_ability != null:
		option_selected.emit(selected_ability)
	_ability_grid.get_children().all(func(card:AbilityCard):
		card.discarded()
		return true
		pass)
	pass

func _on_card_selection_animation_finished_timeout():
	turn_start.emit()
	turn_timer.start(turn_time-turn_warning_time)
	_generate_ability_roster()
	ability_cards.all(func(card:AbilityCard):
		card.selected()
		return true
		pass)
	pass # Replace with function body.
	
#pick 
func _generate_ability_roster():
	var options: Array[AbilityContainer]
	ability_cards.all(func(card:AbilityCard):
		card.ability = available_abilities.pick_random()
		options.push_back(card.ability)
		return true
		pass)
	pass
	selected_ability = null
	options_generated.emit(options)

func ability_selected(index:int):
	var all = ability_cards.duplicate(true)
	var selected = all[index]
	all.erase(selected)
	var unselected = all
	selected.chosen()
	selected_ability = selected.ability
	unselected.all(func(item):
		item.discarded()
		return true
		pass)
	pass
