extends CharacterComponent
class_name TricksterComponent
@onready var timer = %Cooldown
var fake_ball_scene = preload("res://Scenes/Entities/FakeBall.tscn")
const instance_offset = Vector2(15,15)

func main_interact(state):
	if spell_active:
		if state is PossessionState:
			possession_spell()
			cooling_down = true
			timer.start(cooldown)

func possession_spell():
	print("TricksterComponent: Activate possession spell effect")
	var fake_ball = fake_ball_scene.instantiate()
	fake_ball.global_position = get_parent().global_position+(instance_offset*get_parent().facing)
	fake_ball.duration = duration
	add_child(fake_ball)
	spell_active = false


func _on_timer_timeout():
	cooling_down = false
