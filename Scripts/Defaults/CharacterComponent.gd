extends Node
class_name CharacterComponent

var cooling_down: bool = false
var spell_active: bool = false
@export var cooldown: int
@export var duration: int

func secondary_interact(state):
	if not cooling_down:
		spell_active = not spell_active

func main_interact(state):
	pass
