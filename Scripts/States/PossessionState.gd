extends State
class_name PossessionState

func on_enter():
	playback.travel("Move")

func state_input(event : InputEvent):
	pass
		
func state_process(delta):
	if not get_parent().game_component.ball:
		next_state = get_parent().states["Idle"]

func on_depossession(anim_name = null):
	next_state = get_parent().states["Busy"]
	next_state.anim_name = anim_name
	next_state.queued_next_state = get_parent().states["Idle"]

func _on_soccer_component_depossessed(anim_name):
	on_depossession(anim_name)

