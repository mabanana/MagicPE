extends State
class_name IdleState
		
func state_process(delta):
	pass

func on_enter():
	playback.travel("Move")

func on_possession(anim_name):
	next_state = get_parent().states["Busy"]
	next_state.anim_name = anim_name
	next_state.queued_next_state = get_parent().states["Possession"]

func on_main_interact():
	on_possession("Possess")
