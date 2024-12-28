extends Node
class_name NeuroIntegration

var _selected_spells: Array[AbilityContainer]

signal ability_selected(ability: AbilityContainer)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_ai_control_options_generated(options):
	_selected_spells = options
	var description := _getDescription()
	var spells_enum := _getSpellsEnum()

	var actionWindow := ActionWindow.new(self)
	var state := "Vedal has n% of HP, he currently cleared m% of the current area. There're currently h of your allies on the screen. " # we need to have a function that will return the curren state of the player
	var prompt := "You can have a pity for Vedal and give him a little boon, or be merciless and play against him."

	actionWindow.set_force(0, prompt, state)
	actionWindow.add_action(SpellAction.new(actionWindow, self, description, spells_enum))
	actionWindow.register()

	pass # Replace with function body.

func _getDescription() -> String:
	return "You're presented with those options to use. Pick one. " + str(_get_combined_tooltips())

func _getSpellsEnum() -> Array[String]:
	return _get_ability_names()

func _get_ability_by_name(spell_name: String) -> AbilityContainer:
	for ability in _selected_spells:
		if ability.name == spell_name:
			return ability
	return null

func _get_ability_names() -> Array[String]:
	return _selected_spells.map(func(ability): return ability.name)

func _get_combined_tooltips() -> String:
	var combined_tooltip: String = ""
	for ability in _selected_spells:
		combined_tooltip += str(ability.name) + ": "
		combined_tooltip += str(ability.tooltip) + ". "
	return combined_tooltip.strip_edges()

func cast_spell(spell: String) -> void:
	ability_selected.emit(_get_ability_by_name(spell))
