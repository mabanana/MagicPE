extends CPUParticles2D
class_name OTParticle

# Called when the node enters the scene tree for the first time.
func _ready():
	emitting = true
	one_shot = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not emitting:
		queue_free()
