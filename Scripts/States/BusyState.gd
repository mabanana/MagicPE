extends State
var anim_name = null

func on_enter():
	if anim_name:
		playback.travel(anim_name)
		await get_parent().animation_tree.animation_finished
	next_state = get_parent().states["Idle"]
	
func state_process(delta):
	pass

