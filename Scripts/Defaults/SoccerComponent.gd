extends GameComponent
class_name SoccerComponent

const offset = 25
@export var ball_marker = Marker2D
@export var kick_spin: int = 500
@export var kick_speed: int = 70
var state_machine: CharacterStateMachine
var ball: RigidBody2D = null
var ball_detect = preload("res://Scenes/Instances/soccer_joint.tscn")


func main_interact(state):
	if state is PossessionState:
		kick_ball(ball)
		depossess_ball("Kick")
	if state is IdleState:
		if not has_node("SoccerJoint"):
			var inst = ball_detect.instantiate()
			add_child(inst)


func _process(delta):
	ball_marker.position.x = get_parent().facing * offset
	
	
func kick_ball(b: RigidBody2D, is_shoot: bool = true):
	var dir = (get_global_mouse_position() - ball_marker.global_position).normalized()
	if dir.normalized().x * get_parent().facing < 0:
		dir *= 0.5
		print("SoccerComponent: wrong facing")
	if b:
		b.apply_impulse(dir*kick_speed)
		print("SoccerComponent: ", b.name, " was kicked.")
	#ball.apply_torque_impulse(kick_spin*dir.angle())

func _on_soccer_joint_area_entered(area):
	var body = area.get_parent()
	if body is Ball and state_machine.current_state is IdleState:
		print("SoccerComponent:", body.name, " has been possessed")
		body.possess(ball_marker)
		state_machine.current_state.on_possession("Possess")
		ball = body
		print("SoccerComponent: has connected to ",body.name)

func depossess_ball(anim_name = null):
	if ball:
		ball.depossess()
		if state_machine.current_state is PossessionState:
			state_machine.current_state.on_depossession(anim_name)
	ball = null
