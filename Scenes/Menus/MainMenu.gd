extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_tree().paused:
		show()
	else:
		hide()

