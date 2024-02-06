extends State
class_name PossessionState

func on_enter():
	pass

func state_input(event : InputEvent):
	pass
		
func state_process(delta):
	pass

func on_depossession(anim_name = null):
	next_state = get_parent().states["Busy"]
	next_state.anim_name = anim_name

func _on_soccer_component_depossessed(anim_name):
	on_depossession(anim_name)

func main_interact(state_name):
	print("PossessionState: main interact pressed")
	if character.char_component.spell_active:
		character.char_component.spell_active = false
		character.char_component.possession_spell()
	get_parent().game_component.main_interact(state_name)
