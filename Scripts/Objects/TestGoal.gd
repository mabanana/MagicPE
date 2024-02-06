extends Area2D
var goal_text = preload("res://Scenes/UI/TestGoalTextLabel.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body is Ball and not body is FakeBall:
		var text = goal_text.instantiate()
		get_parent().get_node("Control").add_child(text)
