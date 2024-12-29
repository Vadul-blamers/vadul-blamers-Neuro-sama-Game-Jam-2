extends Node

@export
var entity_container: Node

func _ready():
	pass


func _on_ai_control_option_selected(ability:AbilityContainer):
	var position = GameState.player.position
	var effect = ability.on_use.instantiate()
	effect.tree_entered.connect(func():
		effect.position = position
		pass)
	entity_container.add_child(effect)
	
	pass
