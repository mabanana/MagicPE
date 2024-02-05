extends State
class_name IdleState

func state_input(event : InputEvent):
	if event.is_action_pressed("main_interact"):
		print("IdleState: main interact pressed")
	
	elif event.is_action_pressed("secondary_interact"):
		print("IdleState: secondary interact pressed")
		
func _physics_process(delta):
	pass

func on_enter():
	playback.travel("Move")
