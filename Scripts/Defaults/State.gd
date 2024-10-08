extends Node

class_name State

@export var can_move: bool = true
@export var can_cast: bool = true

var character : CharacterBody2D
var next_state: State
var playback: AnimationNodeStateMachinePlayback

func state_process(delta):
	pass

func state_input(event : InputEvent):
	pass

func on_enter():
	pass

func on_exit():
	pass

func on_main_interact():
	pass
	
func main_interact():
	get_parent().game_component.main_interact(self)
	if can_cast:
		get_parent().char_component.main_interact(self)
	on_main_interact()
