extends CanvasLayer

signal quit_pressed
signal char_info_pressed

@onready var team_0_label = $%Team0Score
@onready var team_1_label = $%Team1Score
var score: Array = [0,0]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Scene.scene:
		score = Scene.scene.score
	team_0_label.text = str(score[0])
	team_1_label.text = str(score[1])


func _on_quit_pressed():
	emit_signal("quit_pressed")


func _on_char_info_pressed():
	emit_signal("char_info_pressed")
