extends Node
class_name Events;

var count : int;
var eventList : Node;

#DamageHistory is a sort of average of damage taken by the player when a certain option was selected.
# It should persist between games
@export var historyDecay : float = 1.33;
@export var startHistory : float = 10.0;
var damageHistory : Array[float] = [];

var activeEvent : Event;

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

func getActiveEvent():
	return activeEvent;
	
func getDamageHistory():
	return damageHistory;
	
## Event cycle
# Select possible events
# Get chosen event
# Wait for timer to expire
# Add damage taken during the previous event to damageHistory then divide by decay
# Start next event
