extends Node2D
class_name GameScene

const char_switch_radius: int = 40

var game_mode: GameMode
var characters: Array
var player_characters: Array[PlayerEntity]
var game_ball: Ball
var possession_team: int = -1

@export var player_spawns: Node
@onready var backpackman = preload("res://Scenes/Entities/BackpackMan.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	Scene.scene = self
	game_mode = get_parent().game_mode
	characters = get_parent().characters
	var c = get_parent().characters[0][0]
	characters = [[c,c],[c,c]]
	
	for entity in game_mode.game_entities:
		var new_ent = entity.scene.instantiate()
		new_ent.texture = entity.sprite
		add_child(new_ent)
	game_ball = get_node("Ball")
	
	for team_id in range(len(player_spawns.get_children())):
		var player_spawns_list = player_spawns.get_children()[team_id].get_children()
		
		for i in range(len(characters[team_id])):
			var player = backpackman.instantiate()
			player.game_component_scene = game_mode.game_component
			player.state_machine_scene = game_mode.state_machine
			player.animation_tree_scene = game_mode.animation_tree
			player.char_component_scene = characters[team_id][i].character_component
			player.animation_player_scene = characters[team_id][i].animation_player
			player.global_position = player_spawns_list[i].global_position
			player.team_id = team_id
			# remove second expression for multiplayer
			if i == 0 and team_id == 0:
				player.is_current_player = true
			add_child(player)

	#TODO: Assign the team captains to each player's control
	for child in get_children():
		if child is PlayerEntity:
			player_characters.append(child)


func change_player_control_to(player_character:PlayerEntity):
	if not player_character:
		return
	if not player_character.is_current_player:
		for char in player_characters:
			if char == player_character:
				char.toggle_player_control(true)
			else:
				char.toggle_player_control(false)


func _on_quit_pressed():
	queue_free()

func _on_char_info_pressed():
	#instantiate a char information window and pause game
	pass # Replace with function body.

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
	return arr[closest[0]] if closest[1] > char_switch_radius else null

func connect_possession_signal(soccer_node):
	soccer_node.connect("ball_possessed", _on_ball_possessed)

func _on_ball_possessed(team_id):
	possession_team = team_id
	print("GameScene: ball has been possessed by team: ", team_id)
