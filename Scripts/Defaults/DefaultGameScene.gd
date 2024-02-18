extends Node2D
class_name GameScene

var game_mode: GameMode
var character: CharacterModeResource
var characters = []
var player_characters: Array[PlayerEntity]

@export var player_spawns: Node
@onready var backpackman = preload("res://Scenes/Entities/BackpackMan.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	game_mode = get_parent().game_mode
	character = get_parent().characters[0]
	characters = [character, character]
	
	
	for entity in game_mode.game_entities:
		var new_ent = entity.scene.instantiate()
		new_ent.texture = entity.sprite
		add_child(new_ent)
	
#	var player = backpackman.instantiate()
#	player.game_component_scene = game_mode.game_component
#	player.state_machine_scene = game_mode.state_machine
#	player.animation_tree_scene = game_mode.animation_tree
#	player.char_component_scene = character.character_component
#	player.animation_player_scene = character.animation_player
#	player.global_position = get_node("PlayerSpawn").global_position
#	add_child(player)
	var player_spawns_list = player_spawns.get_children()
	for i in range(len(player_spawns_list)):
		var player = backpackman.instantiate()
		player.game_component_scene = game_mode.game_component
		player.state_machine_scene = game_mode.state_machine
		player.animation_tree_scene = game_mode.animation_tree
		player.char_component_scene = characters[i].character_component
		player.animation_player_scene = characters[i].animation_player
		player.global_position = player_spawns_list[i].global_position
		add_child(player)
	
	for child in get_children():
		if child is PlayerEntity:
			player_characters.append(child)
	player_characters[0].is_current_player = true
		
func change_player_control_to(player_character:PlayerEntity):
	if not player_character.is_current_player:
		for char in player_characters:
			if char == player_character:
				char.toggle_player_control(true)
			else:
				char.toggle_player_control(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_quit_pressed():
	queue_free()

func change_control_to_mouse():
	change_player_control_to(get_closest_to_mouse_pos(player_characters))

func get_closest_to_mouse_pos(arr:Array):
	var mouse_pos = get_global_mouse_position()
	if not arr or not arr[0] is Node2D:
		return null
	var closest = [0, (mouse_pos - arr[0].global_position).length()]
	for i in range(1, len(arr)):
		var distance = (mouse_pos - arr[i].global_position).length()
		if distance < closest[1]:
			closest = [i, distance]
	return arr[closest[0]]
