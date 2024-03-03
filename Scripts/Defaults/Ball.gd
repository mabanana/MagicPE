extends RigidBody2D
class_name Ball

@export var turn_speed: int = 350
@export var spin_multiplier: int = 150
@export var sprite: Sprite2D
@export var hitbox: Area2D

var possessed: bool
var active: bool = true
var possesser: Marker2D
var spawn: Marker2D
var texture

func on_ready():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	possessed = false
	sprite.texture = texture
	on_ready()

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
	if not possesser:
		possessed = false
		Scene.scene._on_ball_possessed(-1)


func _on_area_2d_body_entered(body):
	print("Ball: detected body entering: ",body.name)
	if body.name == "Court" and possesser:
		apply_impulse(possesser.global_position - possesser.get_parent().global_position)
		possesser.get_parent().depossess_ball()


func possess(marker):
	if active and not marker.get_parent().ball:
		possessed = true
		assign_possess(marker)
	
func depossess():
	possessed = false
	possesser = null

func assign_possess(marker):
	Scene.scene.change_player_control_to(marker.get_parent().get_parent())
	possesser = marker

func _on_enter_goal():
	active = false
	depossess()
	possesser = spawn
	possessed = true
	hitbox.monitorable = false
	hitbox.monitoring = false

func _on_game_start():
	active = true
	depossess()
	hitbox.monitorable = true
	hitbox.monitoring = true
