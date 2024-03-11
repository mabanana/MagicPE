extends Node
class_name GameInstance

@export var game_scene: PackedScene
var game_mode: GameMode
var characters: Array
var game_map
var team_id: int = 0

func _ready():
	start_game()

func _on_child_exiting_tree(node):
	if node is GameScene:
		queue_free()
		Scene.scene = null
		
func start_game():
	var new_scene = game_scene.instantiate()
	add_child(new_scene)
