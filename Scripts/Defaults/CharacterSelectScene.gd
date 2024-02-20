extends Node2D
class_name CharacterSelect
@export var game_mode_list_resource: GameModesList
@export var grid_item_scene: PackedScene

const empty_char = [[],[]]

var all_char: Array[CharacterModeResource]
var all_modes: Array[GameMode]
var selected_mode: GameMode
var selected_chars: Array
var current_team_id: int = 0
var current_team: Array[CharacterModeResource]
var team_size: int = 1
var number_of_teams: int = 2


@export var characters_grid: GridContainer
@export var game_modes_grid: GridContainer
@export var continue_button: Button

func _ready():
	continue_button.hide()
	all_modes = game_mode_list_resource.game_modes 
	for mode in all_modes:
		var new_item = grid_item_scene.instantiate()
		new_item.resource = mode
		game_modes_grid.add_child(new_item)
	selected_chars = []

func game_mode_selected(resource):
	selected_mode = resource
	print("CharacterSelect: ", resource.name, " added to mode selection")
	for child in characters_grid.get_children():
		child.queue_free()
		selected_chars = []
		print("CharacterSelect: character grid freed")
	for char in resource.all_char:
		var new_item = grid_item_scene.instantiate()
		new_item.resource = char
		characters_grid.add_child(new_item)

func char_selected(resource):
	if resource not in current_team:
		current_team.append(resource)
		print("CharacterSelect: ", resource.name, " added to character selection")

func select(resource: Resource):
	if resource is GameMode:
		game_mode_selected(resource)
	elif resource is CharacterModeResource:
		char_selected(resource)
		if len(current_team) >= team_size:
			selected_chars.append(current_team)
			current_team_id += 1
	print("CharacterSelect: selected mode,chars = ", selected_mode.name," teams: " ,selected_chars)

func _process(delta):
	if selected_mode and current_team_id >= number_of_teams:
		continue_button.show()

func _on_continue_button_pressed():
	get_parent().create_game_instance(selected_chars, selected_mode)
	queue_free()
