extends Node
class_name CharacterComponent

var spell_active: bool = false
@export var cooldown: int
@export var duration: int

func sec_interaction(state_name):
	pass

func activate_spell():
	pass
