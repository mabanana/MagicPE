extends Camera2D
var ball
var ball_freed = false
@export var x_max_offset: int = 300
@export var y_max_offset: int = 180


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ball and not ball_freed:
		position = ball.position
		if position.x > x_max_offset:
			position.x = x_max_offset
		elif position.y < -x_max_offset:
			position.y = -x_max_offset
		
		if position.y > y_max_offset:
			position.y = y_max_offset
		elif position.y < -y_max_offset:
			position.y = -y_max_offset
