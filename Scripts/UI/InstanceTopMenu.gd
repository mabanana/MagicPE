extends CanvasLayer

signal quit_pressed
signal char_info_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_quit_pressed():
	emit_signal("quit_pressed")


func _on_char_info_pressed():
	emit_signal("char_info_pressed")
