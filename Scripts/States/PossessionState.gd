extends State
class_name PossessionState

func on_enter():
	pass

func state_input(event : InputEvent):
	if event.is_action_pressed("main_interact"):
		print("PossessionState: main interact pressed")
	
	elif event.is_action_pressed("secondary_interact"):
		print("PossessionState: secondary interact pressed")
		
func state_process(delta):
	pass

func main_interact(state_name):
	get_parent().game_component.main_interact(state_name)

func on_depossession():
	next_state = get_parent().states["Idle"]


func _on_soccer_component_depossessed():
	on_depossession()
