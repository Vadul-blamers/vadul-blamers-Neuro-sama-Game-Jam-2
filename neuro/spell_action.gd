extends NeuroAction
class_name SpellAction

var _integration: NeuroIntegration
var _description: String
var _spell_enum: Array[String]

func _init(window: ActionWindow, integration: NeuroIntegration, description: String, spell_enum: Array[String]):
	super(window)
	_integration = integration
	_description = description
	_spell_enum = spell_enum

func _get_name() -> String:
	return "spell"

func _get_description() -> String:
	return _description

func _get_schema() -> Dictionary:
	return JsonUtils.wrap_schema({
		"spell": {
			"enum": _spell_enum
		}
	})

func _validate_action(data: IncomingData, state: Dictionary) -> ExecutionResult:
	var spell := data.get_string("spell")
	if not spell:
		return ExecutionResult.failure(Strings.action_failed_missing_required_parameter.format(["spell"]))

	var spells := _spell_enum
	if not spells.has(spell):
		return ExecutionResult.failure(Strings.action_failed_invalid_parameter.format(["spell"]))

	state["spell"] = spell
	return ExecutionResult.success()

func _execute_action(state: Dictionary) -> void:
	_integration.cast_spell(state["spell"])
