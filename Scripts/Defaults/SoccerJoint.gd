extends Area2D
class_name SoccerJoint

func _ready():
	pass

func _process(delta):
	pass

func _on_area_entered(area):
	get_parent()._on_soccer_joint_area_entered(area)


func _on_timer_timeout():
	queue_free()
