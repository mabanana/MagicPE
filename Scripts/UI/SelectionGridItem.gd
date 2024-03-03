extends TextureButton
class_name SelectionGridItem
@export var resource: Resource
var selected: bool


# Called when the node enters the scene tree for the first time.
func _ready():
	modulate.a = 220
	texture_normal = resource.icon
	selected = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if selected:
		modulate.a = 255


func _on_pressed():
	print("SelectionGridItem: button pressed, this button is for ")
	get_scene().select(resource)
	selected = true

func get_scene(node = self, scene_type = "CharacterSelectScene"):
	var parent = node.get_parent()
	if parent.name == scene_type:
		return parent
	else:
		return get_scene(parent, scene_type)


func _on_mouse_entered():
	self_modulate = Color(1,1,0.8,0.7)


func _on_mouse_exited():
	self_modulate = Color(1,1,1,1)
