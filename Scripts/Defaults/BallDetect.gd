extends Area2D
class_name BallDetect
@export var duration: float = 0.1


func _ready():
	if duration > 0:
		start_timer(duration)

func _process(delta):
	pass

func _on_area_entered(area):
	print(area.get_parent().name)
	if area.get_parent() is Ball:
		get_parent()._on_ball_entered(area)


func _on_timer_timeout():
	queue_free()

func start_timer(duration):
	$Timer.start(duration)
