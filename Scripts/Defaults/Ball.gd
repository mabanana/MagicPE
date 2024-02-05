extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
#	var c = move_and_collide(linear_velocity*delta)
#	if c:
#		print("Ball: ", c)
#		var collider = c.get_collider()
#		print("Ball: ", collider)
#		if collider is RigidBody2D:
#			apply_central_impulse(-linear_velocity*delta)
#			apply_torque(2)

func _on_area_2d_body_entered(body):
	var velocity = body.global_position - global_position
	velocity = velocity.normalized()
	print("Ball: ",body.name, " has collided with ball at", velocity)
	if body is CharacterBody2D:
		apply_central_impulse(-velocity*500)
		apply_torque(2)
