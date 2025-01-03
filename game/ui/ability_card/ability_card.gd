@tool
class_name AbilityCard
extends VBoxContainer

#we want to trigger the card update when the ability on it is changed.
@export 
var ability:AbilityContainer = preload("res://ability/BlankAbility.tres"):
	get:
		return ability
	set(value):
		ability = value
		_update_card()

@onready
var _icon_container = $Control
@onready
var _label = $Label
@onready
var _animation = $AnimationPlayer

var dismissed = false

func _ready():
	_update_card()
	pass

#replace all elements that need replacing.
func _update_card():
	#remove the old icon.
	_icon_container.get_children(true).all(func (child:Node):
		child.queue_free()
		pass)
	_icon_container.add_child(ability.icon.instantiate())
	_label.text = "[center]"+ability.tooltip+"[/center]"
	pass

func _process(delta):
	pass

func selected():
	dismissed = false
	_animation.play("RESET")
	_animation.play("chosen_for_selection")
	pass

func discarded():
	#Do not replay this animation if the card was not dismissed first
	if dismissed:
		return
	dismissed = true
	_animation.play("unselected")
	
func chosen():
	_animation.play("selected")
	
