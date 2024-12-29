extends Node
class_name Items;

var count : int;
var itemList : Array[Item];
var available : Array[Item];
var taken : Array[Item] = [];

func take_item(id):
	taken.append(available[id]);
	available.remove_at(id);

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	itemList = get_node("ItemList").get_children() as Array[Item];
	count = itemList.size();
	available = itemList.duplicate();
 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
