extends CharacterBody2D
class_name PlayerEntity

@export var move_speed: int = 200
@export var acceleration: int = 60
@export var decceleration: int = 20
@export var sprite_2d: Sprite2D

var is_current_player: bool = false

var state_machine: CharacterStateMachine
var animation_tree: AnimationTree
var char_component: CharacterComponent
var game_component: GameComponent

var char_component_scene: PackedScene
var animation_tree_scene: PackedScene
var state_machine_scene: PackedScene
var game_component_scene: PackedScene
var animation_player_scene: PackedScene

var blend_position: Vector2
var x_direction: int
var y_direction: int
var facing: int = 1

func _ready():
	var component_scene_list = [
	game_component_scene, 
	animation_tree_scene,
	char_component_scene, 
	state_machine_scene ]

	for scene in component_scene_list:
		var inst = scene.instantiate()
		add_child(inst)
	
	for child in get_children():
		if child is AnimationTree:
			animation_tree = child
			animation_tree.set_anim_player(animation_player_scene)
		elif child is GameComponent:
			game_component = child
		elif child is CharacterStateMachine:
			state_machine = child
		elif child is CharacterComponent:
			char_component = child
	game_component.state_machine = state_machine
	state_machine.game_component = game_component
	state_machine.char_component = char_component
	
	if game_component.has_method("on_player_control_lost") and not is_current_player:
		game_component.on_player_control_lost()
	
func _physics_process(delta):
	if x_direction or y_direction:
		var acc = (sqrt(0.5)*acceleration) if (x_direction and y_direction) else acceleration 
		velocity.x = move_toward(velocity.x, x_direction * move_speed, acceleration)
		velocity.y = move_toward(velocity.y, y_direction * move_speed, acceleration)
		velocity = velocity.normalized() * min(velocity.length(),move_speed)
	else:
		velocity.y = move_toward(velocity.y, 0, decceleration)
		velocity.x = move_toward(velocity.x, 0, decceleration)
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
	blend_position.x = velocity.x
	blend_position.y = velocity.y
	# Sends parameter data to the animation tree
	animation_tree.set("parameters/Move/blend_position", blend_position.normalized())

func _input(event):
	if is_current_player:
		if state_machine.is_can_move():
			x_direction = Input.get_axis("ui_left", "ui_right")
			y_direction = Input.get_axis("ui_up", "ui_down")
		else:
			x_direction = 0
			y_direction = 0
		
		if event.is_action_pressed("ui_accept"):
			pass
		
		elif event.is_action_pressed("main_interact"):
			print("PlayerEntity: Main Interact pressed")
			state_machine.current_state.main_interact()
			if state_machine.is_can_cast():
				char_component.main_interact(state_machine.current_state)
		
		elif event.is_action_pressed("secondary_interact"):
			print("PlayerEntity: Secondary Interact pressed")
			if state_machine.is_can_cast():
				char_component.secondary_interact(state_machine.current_state)
		state_machine.state_machine_input(event)
