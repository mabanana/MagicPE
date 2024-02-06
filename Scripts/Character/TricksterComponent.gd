extends CharacterComponent
class_name TricksterComponent

var fake_ball_scene = preload("res://Scenes/Entities/FakeBall.tscn")
const instance_offset = Vector2(15,15)

func possession_spell():
	print("TricksterComponent: Activate possession spell effect")
	var fake_ball = fake_ball_scene.instantiate()
	fake_ball.global_position = get_parent().global_position+(instance_offset*get_parent().facing)
	fake_ball.duration = duration
	add_child(fake_ball)
