class_name AbilityContainer
extends Resource

#Identifier that that should also be passed to Neuro
@export
var name:StringName

#description that that should also be passed to Neuro
@export_multiline
var description:String =""

#Text used when the action shows on the UI
@export
var tooltip:StringName = "fill me"

# displays the action in-game
@export
var icon:PackedScene

#spawned into the scene on use.
#it WILL appear on top of the player!
@export
var on_use:PackedScene

@export
var is_positive: bool = false

func specialWeightFactor():
	return 1;
