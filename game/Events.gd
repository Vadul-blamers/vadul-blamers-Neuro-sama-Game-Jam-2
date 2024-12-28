extends Node
var count : int;
var eventList : Node;

#DamageHistory is a sort of average of damage taken by the player when a certain option was selected.
@export var historyDecay : int = 4;
@export var startHistory : int = 10;
var damageHistory : Array[int] = [];

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	eventList = get_node("EventList");
	count = eventList.get_child_count();
	damageHistory.resize(count);
	damageHistory.fill(startHistory);

 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func getEvent(x : int):
	return eventList.getChild(x).getScript as Event;
