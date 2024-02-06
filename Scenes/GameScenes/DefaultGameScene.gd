extends Node2D
class_name GameScene

@export var game_component: PackedScene
@export var state_machine_component: PackedScene
@export var character_component: PackedScene
@export var animation_tree_component: PackedScene
var backpackman = preload("res://Scenes/Entities/BackpackMan.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	var player = backpackman.instantiate()
	player.game_component_scene = game_component
	player.state_machine_scene = state_machine_component
	player.animation_tree_scene = animation_tree_component
	player.char_component_scene = character_component
	player.global_position = get_node("PlayerSpawn").global_position
	add_child(player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
