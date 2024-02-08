extends State
class_name BusyState

var anim_name = null
var animation_finished: bool = false
var queued_next_state: State

func on_enter():
	if anim_name:
		playback.travel(anim_name)
		await get_parent().animation_tree.animation_finished
		animation_finished = true
	if animation_finished:
		next_state = queued_next_state if queued_next_state else get_parent().states["Idle"]
	
func state_process(delta):
	pass

