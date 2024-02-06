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

func on_possession(anim_name):
	next_state = get_parent().states["Busy"]
	next_state.anim_name = anim_name
	next_state.next_state = get_parent().states["Possession"]

func _on_soccer_component_possessed(anim_name):
	on_possession(anim_name)

