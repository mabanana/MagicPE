extends Camera2D
class_name GameCamera

var ball
var targets: Array = []
var center: Vector2 = Vector2.ZERO
var z
@onready var screen_size = get_viewport_rect().size

@export var x_max_offset: int = 300
@export var y_max_offset: int = 100
@export var margin: Vector2 = Vector2(120,20)
@export var move_speed: float = 0.5
@export var zoom_speed: float = 0.05
@export var max_zoom: float = 1.5
@export var min_zoom: float = 0.8


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	targets = []
	if ball:
		targets.append(ball)
	for char in get_parent().player_characters:
		if char.is_current_player:
			targets.append(char)
	
	center = find_center()
	z = find_zoom()
	position = lerp(position, center, move_speed)
	zoom = lerp(zoom, Vector2.ONE * z, zoom_speed)
	
	if abs(position.x) > x_max_offset:
		position.x /= abs(position.x)
		position.x *= x_max_offset
	if abs(position.y) > y_max_offset:
		position.y /= abs(position.y)
		position.y *= y_max_offset


func find_center():
	if len(targets) == 0:
		return Vector2(0,0)
	if len(targets) == 1:
		return targets[0].position
	var center = Vector2.ZERO
	for x in targets:
		center += x.position
	center /= len(targets)
	
	return center


func find_zoom():
	var r = Rect2(center, Vector2.ONE)
	for target in targets:
		r = r.expand(target.position)
	r = r.grow_individual(margin.x, margin.y, margin.x, margin.y)
	
	if r.size.x > r.size.y * screen_size.aspect():
		return clamp(screen_size.x / r.size.x, min_zoom, max_zoom)
	else:
		return clamp(screen_size.y / r.size.y, min_zoom, max_zoom)
