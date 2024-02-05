extends CharacterBody2D
class_name PlayerEntity

@export var move_speed: int = 200
@export var state_machine: CharacterStateMachine
@export var animation_tree: AnimationTree
@export var sprite_2d: Sprite2D

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	var x_direction = Input.get_axis("ui_left", "ui_right")
	var y_direction = Input.get_axis("ui_up", "ui_down")
	var main_interact = Input.is_action_just_pressed("main_interact")
	var sec_interact = Input.is_action_just_pressed("secondary_interact")


	if Input.is_action_just_pressed("ui_accept"):
		if state_machine.current_state.name == "Idle":
			state_machine.current_state.next_state = state_machine.states["Possession"]
		if state_machine.current_state.name == "Possession":
			state_machine.current_state.next_state = state_machine.states["Idle"]


	if x_direction:
		velocity.x = x_direction * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
	if y_direction:
		velocity.y = y_direction * move_speed
	else:
		velocity.y = move_toward(velocity.x, 0, move_speed)
	
	check_facing(x_direction)
	
	var blend_position: Vector2
	blend_position.x = x_direction
	blend_position.y = y_direction
	# Sends parameter data to the animation tree
	animation_tree.set("parameters/Move/blend_position", blend_position)
	state_machine.state_machine_process(delta)
	print("PlayerEntity: Velocity(x,y):", velocity.x, velocity.y)
	print("PlayerEntity: GlobalPosition(x,y):", global_position.x, global_position.y)
	print("PlayerEntity: InputDirection: x",x_direction, ", y", y_direction)
	print("PlayerEntity: MainInteract:", main_interact)
	print("PlayerEntity: MainInteract:", sec_interact)


	move_and_slide()
	

func check_facing(input_dir: int = 0):
	var dir: int
	if input_dir != 0:
		dir = input_dir
	else: 
		dir = velocity.x
	if dir < 0:
		sprite_2d.flip_h = true
	elif dir > 0:
		sprite_2d.flip_h = false
