extends Resource
class_name CharacterResource

@export var name: String
@export var icon: Texture
var resources_dir: String = "res://Resources/"
#@export var skin


#func _init():
#	dir_contents(resources_dir)
#	pass
#func dir_contents(path):
#	var dir = DirAccess.open(path)
#	if dir:
#		dir.list_dir_begin()
#		var file_name = dir.get_next()
#		while file_name != "":
#			if dir.current_is_dir():
#				print("Found directory: " + file_name)
#			else:
#				print("Found file: " + resources_dir+file_name)
#				var node = ResourceLoader.load(resources_dir+file_name)
#				print("Found node: ", node)
#				if node is CharacterAnimationTree:
#					print("Found CharacterAnimationTree: ", node)
#					animation_trees.append(node)
#
#			file_name = dir.get_next()
#	else:
#		print("An error occurred when trying to access the path.")
