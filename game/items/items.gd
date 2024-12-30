extends Node
class_name Items;
@export var choices = 3;
var count : int;
var itemList : Array[Item];
var available : Array[Item];
var taken : Array[Item] = [];


func take_item(item):
	var id = available.find(item, 0);
	taken.append(item);
	available.remove_at(id);

func give_options():
	var left = available.duplicate();
	var options : Array[Item] = [];
	for i in choices:
		var option = randi() % left.size();
		options.append(left[option]);
		left.remove_at(option);
	return options;
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	itemList = get_node("ItemList").get_children() as Array[Item];
	count = itemList.size();
	available = itemList.duplicate();
 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
