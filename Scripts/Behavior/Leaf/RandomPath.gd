extends ActionLeaf
class_name RandomPath


func tick(actor: Node, blackboard: Blackboard) -> int:
	actor.get_parent().y_direction = randi_range(-1,1)
	actor.get_parent().x_direction = randi_range(-1,1)
	return SUCCESS
