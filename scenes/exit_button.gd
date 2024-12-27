extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	var platform = OS.get_name()
	if platform == "Web":
		queue_free()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
