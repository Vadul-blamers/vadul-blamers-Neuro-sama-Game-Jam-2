extends Control

@export 
var turn_timer:Timer
@export 
var turn_about_to_end_timer:Timer
@export 
var turn_time = 30
@export
var turn_warning_time = 5

@export
var timer_color:Color

@export
var timer_warning_color:Color

@onready
var _timer_bar = $MainContainer/VBoxContainer/TimerContainer/TimerBar

signal turn_about_to_end
signal turn_end

# Called when the node enters the scene tree for the first time.
func _ready():
	turn_timer.timeout.connect(func():
		turn_about_to_end_timer.start(turn_warning_time)
		pass)
	turn_timer.start(turn_time-turn_warning_time)
	_timer_bar.max_value = turn_time+turn_warning_time
	
	pass # Replace with function body.

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
	turn_timer.start(turn_time-turn_warning_time)
	_timer_bar.tint_progress = timer_color
	pass
