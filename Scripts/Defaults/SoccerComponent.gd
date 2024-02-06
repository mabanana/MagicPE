extends GameComponent
class_name SoccerComponent

const offset = 25
@export var ball_marker = Marker2D
@export var kick_spin: int = 500
@export var kick_speed: int = 40
var ball: RigidBody2D
signal possessed
signal depossessed


func main_interact(state_name):
	if state_name == "Possession":
		kick_ball()

func _process(delta):
	ball_marker.position.x = get_parent().facing * offset

func kick_ball(is_shoot: bool = true):
	var dir = (get_global_mouse_position() - ball_marker.global_position).normalized()
	ball.depossess()
	emit_signal("depossessed")
	if dir.normalized().x * get_parent().facing < 0:
		dir *= 0.5
		print("SoccerComponent: wrong facing")
	print("SoccerComponent: ", dir, " ", get_local_mouse_position().normalized())
	ball.apply_impulse(dir*kick_speed)
	#ball.apply_torque_impulse(kick_spin*dir.angle())

func _on_soccer_joint_area_entered(area):
	if area.get_parent().has_method("possess"):
		print("SoccerComponent:",area.get_parent().name, " possessed")
		area.get_parent().possess(ball_marker)
		emit_signal("possessed")
		ball = area.get_parent()
		print("SoccerJoint: has connected to ",area.get_parent().name)
