extends ConditionLeaf
class_name BallInRange
@export var detect_range: int = 200
var ball

func _ready():
	ball = Scene.scene.game_ball
	
func tick(actor: Node, blackboard: Blackboard) -> int:
	var displacement = ball.global_position - actor.global_position
	if displacement.length() < detect_range:
		return SUCCESS
	return FAILURE
