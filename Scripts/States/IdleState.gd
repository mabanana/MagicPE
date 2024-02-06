extends State
class_name IdleState

func state_input(event : InputEvent):
	if event.is_action_pressed("main_interact"):
		print("IdleState: main interact pressed")
	
	elif event.is_action_pressed("secondary_interact"):
		print("IdleState: secondary interact pressed")
		
func state_process(delta):
	pass

func on_enter():
	playback.travel("Move")

func on_possession():
	next_state = get_parent().states["Possession"]

func _on_soccer_component_possessed():
	on_possession()

