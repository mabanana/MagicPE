extends Node
class_name GameInstance

@export var game_scene: PackedScene
var game_mode: GameMode
var characters: Array[CharacterResource]
var game_map

func _ready():
	var new_scene = game_scene.instantiate()
	add_child(new_scene)


func _on_child_exiting_tree(node):
	if get_child_count() == 0:
		queue_free()
