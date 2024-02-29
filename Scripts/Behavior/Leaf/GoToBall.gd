extends ActionLeaf
class_name GoToBall
var ball

func _ready():
	ball = Scene.scene.game_ball
	
func tick(actor: Node, blackboard: Blackboard) -> int:
	var direction = ball.global_position - actor.global_position
	if direction.length() < 10:
		direction = Vector2(0,0)
		return FAILURE
	direction.normalized()
	actor.get_parent().x_direction = direction.x
	actor.get_parent().y_direction = direction.y
	return SUCCESS
