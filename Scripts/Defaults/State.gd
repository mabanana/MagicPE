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
	
func main_interact(state_name: String):
	get_parent().game_component.main_interact(state_name)
