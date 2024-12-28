extends NeuroAction

const Play := preload("res://game/play.gd")

var _play: Play

func _init(window: ActionWindow, play: Play):
	super(window)
	_play = play

func _get_name() -> String:
	return "spell"

func _get_description() -> String:
	return "You can choose between those spells. Pick one."

func _get_schema() -> Dictionary:
	return JsonUtils.wrap_schema({
		"spell": {
			"enum": _get_spells()
		}
	})

func _validate_action(data: IncomingData, state: Dictionary) -> ExecutionResult:
	var spell := data.get_string("spell")
	if not spell:
		return ExecutionResult.failure(Strings.action_failed_missing_required_parameter.format(["spell"]))

	var spells := _get_spells()
	if not spells.has(spell):
		return ExecutionResult.failure(Strings.action_failed_invalid_parameter.format(["spell"]))

	state["spell"] = spell
	return ExecutionResult.success()

func _execute_action(state: Dictionary) -> void:
	_play.cast_spell(state["spell"])

func _get_spells() -> Array[String]:
	# not sure yet how to pass available spells from the game itself
	# but they have to be randomized inside the game to first show in UI
	# and then passed here
	return ["attack"]
