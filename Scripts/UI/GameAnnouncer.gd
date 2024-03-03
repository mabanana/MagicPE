extends CanvasLayer
class_name GameAnnouncer
@export var label: Label
@export var anim: AnimationPlayer
signal announcer_finished


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func display_text(txt, playback_speed = 1):
	label.text = txt
	anim.play("DisplayText", -1, playback_speed)
	await anim.animation_finished
	emit_signal("announcer_finished")
	
