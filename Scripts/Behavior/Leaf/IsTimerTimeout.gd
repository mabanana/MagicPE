extends ConditionLeaf
class_name IsTimerTimeout

var timeout: bool = false


func tick(actor: Node, blackboard: Blackboard) -> int:
	if timeout:
		timeout = false
		return SUCCESS
	else:
		actor.get_parent().y_direction = 0
		actor.get_parent().x_direction = 0
		return RUNNING


func _on_timer_timeout():
	timeout = true
