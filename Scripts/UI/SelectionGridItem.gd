extends TextureButton
class_name SelectionGridItem
@export var resource: Resource


# Called when the node enters the scene tree for the first time.
func _ready():
	texture_normal = resource.icon


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	print("SelectionGridItem: button pressed, this button is for ", resource.name)
	get_scene().select(resource)
	
	
func get_scene(node = self, scene_type = "CharacterSelectScene"):
	var parent = node.get_parent()
	print(parent.name)
	if parent.name == scene_type:
		return parent
	else:
		return get_scene(parent, scene_type)
