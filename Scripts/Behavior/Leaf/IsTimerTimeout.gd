extends ConditionLeaf
class_name IsTimerTimeout

var timeout: bool = false


func tick(actor: Node, blackboard: Blackboard) -> int:
	if timeout:
		timeout = false
		actor.get_parent().y_direction = randi_range(-1,1)
		actor.get_parent().x_direction = randi_range(-1,1)
		return SUCCESS
	else:
		actor.get_parent().y_direction = 0
		actor.get_parent().x_direction = 0
		return SUCCESS


func _on_timer_timeout():
	timeout = true
