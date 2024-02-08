extends Node
class_name CharacterStateMachine

@export var current_state : State
@export var character: CharacterBody2D
@export var animation_tree: AnimationTree
@export var game_component: GameComponent
var char_component: CharacterComponent
var states : Dictionary = {}

func _ready():
	character = get_parent()
	for child in get_parent().get_children():
		if child is AnimationTree:
			animation_tree = child
	
	for child in get_children():
		if child is State:
				states[child.name] = child
				# Set the state up with what they need to function
				child.character = character
				child.playback = animation_tree["parameters/playback"]
		else:
			push_warning("CharacterStateMachine:  " + child.name + " is not a State for CharacterStateMachine")
	current_state = states["Idle"]
	
		


func state_machine_process(delta):
	if current_state.next_state != null:
		print(str(character.name),"ChacterStateMachine:", str(character.name), " has entered " + str(current_state.next_state.name) + " from " + str(current_state.name))
		switch_states(current_state.next_state)
	current_state.state_process(delta)


func is_can_move():
	return current_state.can_move
	
func is_can_cast():
	return current_state.can_cast

func switch_states(new_state):
	if current_state != null:
		current_state.on_exit()
		current_state.next_state = null
	current_state = new_state
	current_state.on_enter()

func state_machine_input(event: InputEvent):
	current_state.state_input(event)
