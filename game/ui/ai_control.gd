#controls and displays the actions of the AI agent.
extends Control

@export 
var turn_timer:Timer
@export 
var turn_about_to_end_timer:Timer
@export 
var card_selection_finished_timer:Timer

@export
var turn_time = Config.turn_time
@export
var turn_warning_time = Config.turn_warning_time

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
var _ability_grid = $MainContainer/VBoxContainer/Panel/MarginContainer/AbilityGrid

var ability_cards:Array[AbilityCard] = []
var selected_ability:AbilityContainer = null

var _positive_abilities: Array[AbilityContainer]
var _negative_abilities: Array[AbilityContainer]

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
	_timer_bar.max_value = turn_time+turn_warning_time
	_ability_grid.get_children().all(func(item:Node):
		ability_cards.push_back(item as AbilityCard)
		return true
	)
	available_abilities.all(func(ability:AbilityContainer):
		if ability.is_positive:
			_positive_abilities.push_back(ability)
			pass
		else:
			_negative_abilities.push_back(ability)
			pass
		return true
		pass)
	_maximum_positive_events = ability_cards.size()-1
	_generate_ability_roster()
	pass

func _process(delta):
	var value = 0.0
	if not turn_timer.is_stopped():
		value = turn_timer.time_left+turn_warning_time
		pass
	else:
		value = turn_about_to_end_timer.time_left
		pass
	_timer_bar.set_value_no_signal(value)
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


var _positive_events = 0
var _maximum_positive_events = 4

#How positive events should work:
# - Initially there are zero to select
# - When a negative event is selected it increases the amount of positive events next time
# - Weight of positive events is low but multiplied by sqrt(positive events)
# ignores the weight for now, if it's implemented then it will probably be done by adding multiple versions of the same item into the roster.
func _pick_options()-> Array[AbilityContainer]:
	var picked:Array[AbilityContainer] = []
	var available_positive = _positive_abilities.duplicate()
	if _positive_events>0 :
		for i in range(0,_positive_events):
			var current = available_positive.pick_random()
			picked.push_back(current)
			available_positive.erase(current)
			pass
		pass
	var available_negative = _negative_abilities.duplicate()
	for i in range(picked.size()-1,ability_cards.size()-1):
		var current = available_negative.pick_random()
		picked.push_back(current)
		available_negative.erase(current)
		pass
	picked.shuffle()
	return picked

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
	if selected_ability.is_positive:
		if _positive_events >0:
			_positive_events-=1
	else:
		if _positive_events< _maximum_positive_events:
			if randf() >.5:
				_positive_events += 1
		pass
	unselected.all(func(item):
		item.discarded()
		return true
		pass)
	pass

# The index is needed to figure how to handle the whole process.
func ability_selected_by_data(ability:AbilityContainer):
	var cards = ability_cards.filter(func(item:AbilityCard):
		return item.ability.name == ability.name
		pass)
	# if the input was not valid, pick 0
	if cards.is_empty():
		ability_selected(0)
		return
	var card =  cards[0]
	var index = ability_cards.find(card)
	ability_selected(index)
	pass
