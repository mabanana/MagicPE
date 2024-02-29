extends ConditionLeaf
class_name BallInRange
@export var chase_range: int = 300

	
func tick(actor: Node, blackboard: Blackboard) -> int:
	if actor.is_chase:
		var distance = actor.chase_target.global_position - actor.global_position
		if distance.length() < chase_range:
			return SUCCESS
	
	return FAILURE
