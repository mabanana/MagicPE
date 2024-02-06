extends GameComponent
class_name SoccerComponent

const offset = 25
@export var ball_marker = Marker2D
@export var kick_spin: int = 500
@export var kick_speed: int = 70
var ball: RigidBody2D = null
var ball_detect = preload("res://Scenes/Instances/soccer_joint.tscn")
signal possessed
signal depossessed


func main_interact(state_name):
	if state_name == "Possession":
		kick_ball(ball)
		depossess_ball("Kick")
	if state_name == "Idle":
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
	b.apply_impulse(dir*kick_speed)
	print("SoccerComponent: ", b.name, " was kicked.")
	#ball.apply_torque_impulse(kick_spin*dir.angle())

func _on_soccer_joint_area_entered(area):
	if area.get_parent() is Ball and ball == null and get_parent().state_machine.is_can_cast():
		print("SoccerComponent:",area.get_parent().name, " possessed")
		area.get_parent().possess(ball_marker)
		emit_signal("possessed")
		ball = area.get_parent()
		print("SoccerJoint: has connected to ",area.get_parent().name)

func depossess_ball(anim_name = null):
	if ball:
		ball.depossess()
		emit_signal("depossessed", anim_name)
	ball = null

