extends Area2D
class_name SoccerJoint

const offset = 25
@export var ball_marker = Marker2D

func _ready():
	pass # Replace with function body.

func _process(delta):
	ball_marker.position.x = get_parent().facing * offset

func _on_area_entered(area):
	print("SoccerJoint:",area.get_parent().name, " entered")
	print("SoccerJoint: ", area.get_parent().name)
	if area.get_parent().has_method("possess"):
		area.get_parent().possess(ball_marker)
		print("SoccerJoint: has connected to ",area.get_parent().name)
