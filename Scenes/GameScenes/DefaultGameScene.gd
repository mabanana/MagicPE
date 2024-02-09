extends Node2D
class_name GameScene

var game_mode: GameMode
var character: CharacterResource
@onready var backpackman = preload("res://Scenes/Entities/BackpackMan.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	game_mode = get_parent().game_mode
	character = get_parent().characters[0]
	
	var player = backpackman.instantiate()
	player.game_component_scene = game_mode.game_component
	player.state_machine_scene = game_mode.state_machine
	player.animation_tree_scene = character.animation_tree
#	for animation_tree in character.animation_trees:
#		print("animation tree character matches: ",animation_tree.character == character)
#		if animation_tree.game_mode == game_mode:
#			player.animation_tree_scene = animation_tree.animation_tree
	player.char_component_scene = character.character_component
	player.global_position = get_node("PlayerSpawn").global_position
	add_child(player)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
