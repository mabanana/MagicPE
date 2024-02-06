extends State
class_name PossessionState

func state_input(event : InputEvent):
	if event.is_action_pressed("main_interact"):
		print("PossessionState: main interact pressed")
	
	elif event.is_action_pressed("secondary_interact"):
		print("PossessionState: secondary interact pressed")
		
func _physics_process(delta):
	pass

func main_interact(state_name):
	get_parent().game_component.main_interact(state_name)
