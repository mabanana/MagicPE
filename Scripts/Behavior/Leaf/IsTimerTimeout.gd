extends ConditionLeaf
class_name IsTimerTimeout

var timeout: bool = false


func tick(actor: Node, blackboard: Blackboard) -> int:
	if timeout:
		return SUCCESS
	else:
		return FAILURE


func _on_timer_timeout():
	timeout = true
