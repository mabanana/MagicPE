extends Label
var base_text = "Ball is in possession of team: "

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Scene.scene:
		text = base_text + str(Scene.scene.possession_team) 
