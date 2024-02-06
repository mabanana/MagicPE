extends State


func on_enter():
	playback.travel("Kick")
	await get_parent().animation_tree.animation_finished
	next_state = get_parent().states["Idle"]
	
func state_process(delta):
	pass
