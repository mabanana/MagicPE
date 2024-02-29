extends ActionLeaf
class_name GoToMarker

var marker_location: Vector2

func tick(actor: Node, blackboard: Blackboard) -> int:
	if not marker_location:
		marker_location = actor.global_position
	var direction = marker_location - actor.global_position
	if direction.length() < 5:
		direction = Vector2(0,0)
		return SUCCESS
	direction.normalized()
	actor.get_parent().x_direction = direction.x
	actor.get_parent().y_direction = direction.y
	return RUNNING
