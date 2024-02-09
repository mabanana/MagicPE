extends RigidBody2D
class_name Ball
var possessed: bool
var possesser: Marker2D
const turn_speed: int = 350
const spin_multiplier: int = 150
var texture
@export var sprite: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	possessed = false
	sprite.texture = texture

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if possessed:
		var direction: int = 0
		if (possesser.global_position.x - global_position.x) >= 0:
			direction = 1
		elif (possesser.global_position.x - global_position.x) < 0:
			direction = -1
		var speed = (possesser.global_position - global_position).length()
		rotation_degrees += direction * spin_multiplier * delta * speed
		global_position.x = move_toward(global_position.x, possesser.global_position.x, turn_speed*delta)
		global_position.y = move_toward(global_position.y, possesser.global_position.y, turn_speed*delta)

func _on_area_2d_body_entered(body):
	print("Ball: detected body entering: ",body.name)
	if body.name == "Court" and possesser:
		apply_impulse(possesser.global_position - possesser.get_parent().global_position)
		possesser.get_parent().depossess_ball()
		
		
func possess(marker):
	possessed = true
	sleeping = true
	assign_possess(marker)
	
func depossess():
	possessed = false
	sleeping = false
	possesser = null

func assign_possess(marker):
	possesser = marker
