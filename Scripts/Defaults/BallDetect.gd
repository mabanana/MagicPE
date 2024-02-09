extends Area2D
class_name BallDetect
@export var duration: float = 0.1


func _ready():
	$Timer.start(duration)

func _process(delta):
	pass

func _on_area_entered(area):
	get_parent()._on_ball_entered(area)


func _on_timer_timeout():
	queue_free()
