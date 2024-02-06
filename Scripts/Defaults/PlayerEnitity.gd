extends CharacterBody2D
class_name PlayerEntity

@export var move_speed: int = 200
@export var state_machine: CharacterStateMachine
@export var animation_tree: AnimationTree
@export var sprite_2d: Sprite2D
@export var char_component: CharacterComponent
var blend_position: Vector2
var x_direction: int
var y_direction: int
var facing: int = 1

func _ready():
	pass

func _physics_process(delta):
	x_direction = Input.get_axis("ui_left", "ui_right")
	y_direction = Input.get_axis("ui_up", "ui_down")
	
	if not x_direction and not y_direction:
		velocity.y = move_toward(velocity.x, 0, move_speed)
		velocity.x = move_toward(velocity.x, 0, move_speed)
	else:
		velocity.x = x_direction
		velocity.y = y_direction
		velocity = velocity.normalized() * move_speed
	#print("PlayerEntity: Velocity(x,y):", velocity.x, velocity.y)
	#print("PlayerEntity: GlobalPosition(x,y):", global_position.x, global_position.y)
	#print("PlayerEntity: InputDirection: x",x_direction, ", y", y_direction)
	check_facing()
	pass_blend_position()
	state_machine.state_machine_process(delta)


	move_and_slide()
	

func check_facing():
	var dir: int
	if x_direction != 0:
		dir = x_direction
	else: 
		dir = velocity.x
	if dir < 0:
		sprite_2d.flip_h = true
		facing = -1
	elif dir > 0:
		sprite_2d.flip_h = false
		facing = 1

func pass_blend_position():
	blend_position.x = x_direction
	blend_position.y = y_direction
	# Sends parameter data to the animation tree
	animation_tree.set("parameters/Move/blend_position", blend_position)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		pass
	elif event.is_action_pressed("main_interact"):
		print("PlayerEntity: Main Interact pressed")
		state_machine.current_state.main_interact(state_machine.current_state.name)
	elif event.is_action_pressed("secondary_interact"):
		char_component.spell_active = true
		print("PlayerEntity: Secondary Interact pressed")
	state_machine.state_machine_input(event)

func connect_character_component(incoming_character_component):
	char_component = incoming_character_component
