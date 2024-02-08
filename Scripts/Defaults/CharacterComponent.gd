extends Node
class_name CharacterComponent

var spell_active: bool = false
@export var cooldown: int
@export var duration: int

func secondary_interact(state):
	spell_active = not spell_active

func main_interact(state):
	pass
