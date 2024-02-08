extends Label
class_name DebugLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var char = get_parent().char_component
	var spell_active = char.spell_active
	var state = get_parent().state_machine.current_state.name
	if spell_active:
		spell_active = "Spell Active, "
	else:
		if char.cooling_down:
			spell_active = "CD " + str(int(char.timer.time_left)) + ", "

		else:
			spell_active = ""
	text = spell_active + state
