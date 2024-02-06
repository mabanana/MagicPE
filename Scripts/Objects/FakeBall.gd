extends Ball
class_name FakeBall
var kick_speed: int = 400
@export var timer: Timer
var duration: int = 3

func _ready():
	print("FakeBall: ready")
	possessed = false
	timer.start(duration)
	random_kick()

func random_kick():
	var direction: Vector2 = get_local_mouse_position().normalized()
	var random_offset: Vector2 = Vector2(0,randf_range(-0.3,0.3))
	direction = direction + random_offset
	direction = direction.normalized()
	apply_impulse(direction*kick_speed)
	print("FakeBall: Kicked towards ", direction)


func _on_timer_timeout():
	if possesser:
		possesser.get_parent().depossess_ball()
	print("FakeBall: queue free")
	queue_free()
