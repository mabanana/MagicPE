extends ConditionLeaf
class_name BallPossessedByAlly

var ball

func _ready():
	ball = Scene.scene.game_ball	

func tick(actor: Node, blackboard: Blackboard) -> int:
	if Scene.scene.possession_team == actor.get_parent().team_id:
		return SUCCESS
	return FAILURE

