extends ActionLeaf
class_name GoToBall
var ball

func _ready():
	ball = Scene.scene.game_ball
	
func tick(actor: Node, blackboard: Blackboard) -> int:
	if actor.chase_target:
		ball = actor.chase_target
	
	var direction = ball.global_position - actor.global_position
	if direction.length() < 2:
		direction = Vector2(0,0)
		return SUCCESS
	direction.normalized()
	actor.get_parent().x_direction = direction.x
	actor.get_parent().y_direction = direction.y
	return FAILURE
