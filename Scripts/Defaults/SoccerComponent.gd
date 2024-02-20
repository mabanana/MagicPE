extends GameComponent
class_name SoccerComponent

const offset = 25
@export var ball_marker = Marker2D
@export var kick_spin: int = 500
@export var kick_speed: int = 70
@export var ball_detect: PackedScene
var state_machine: CharacterStateMachine
var ball: RigidBody2D = null
var is_chase: bool = false
var chase_target: RigidBody2D

func main_interact(state):
	if state is PossessionState:
		kick_ball(ball)
		depossess_ball("Kick")
	if state is IdleState:
		if not has_node("BallDetect"):
			var inst = ball_detect.instantiate()
			add_child(inst)

func _process(delta):
	ball_marker.position.x = get_parent().facing * offset
	if ball and ball.possesser != ball_marker:
		if state_machine.current_state is PossessionState:
			state_machine.current_state.on_depossession()
		ball = null
	if not get_parent().is_current_player:
		chase()
	
func kick_ball(b: RigidBody2D, is_shoot: bool = true):
	var dir = (get_global_mouse_position() - ball_marker.global_position).normalized()
	if dir.normalized().x * get_parent().facing < 0:
		dir *= 0.5
		print("SoccerComponent: wrong facing")
	if b:
		b.apply_impulse(dir*kick_speed)
		print("SoccerComponent: ", b.name, " was kicked.")
	#ball.apply_torque_impulse(kick_spin*dir.angle())

func _on_ball_entered(area):
	var body = area.get_parent()
	if body is Ball:
		print("SoccerComponent:", body.name, " has been possessed")
		body.possess(ball_marker)
		ball = body
		print("SoccerComponent: has connected to ",body.name)

func depossess_ball(anim_name = null):
	if ball:
		ball.depossess()
	if state_machine.current_state is PossessionState:
		state_machine.current_state.on_depossession(anim_name)
	ball = null

func on_possess_ball():
	on_player_control()

func on_player_control_lost():
	pass
	
func on_player_control():
	pass


func _on_possess_detect_area_entered(area):
	if area.get_parent() is Ball and not get_parent().is_current_player:
		state_machine.current_state.main_interact()


func _on_chase_detect_area_entered(area):
	if area.get_parent() is Ball:
		is_chase = true
		chase_target = area.get_parent()
		
func _on_chase_detect_area_exited(area):
	if area.get_parent() is Ball:
		is_chase = false
		chase_target = null

func chase():
	if is_chase:
		var direction = chase_target.global_position - global_position
		if direction.length() < 10:
			direction = Vector2(0,0)
		direction.normalized()
		get_parent().x_direction = direction.x
		get_parent().y_direction = direction.y
	else:
		get_parent().x_direction = 0
		get_parent().y_direction = 0
