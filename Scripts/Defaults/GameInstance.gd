extends Node
class_name GameInstance

@export var game_scene: PackedScene
var game_mode: GameMode
var characters: Array
var game_map
var team_id: int = 0

func _ready():
	var new_scene = game_scene.instantiate()
	add_child(new_scene)

func _on_child_exiting_tree(node):
	if node is GameScene:
		queue_free()
		Scene.scene = null
