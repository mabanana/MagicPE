extends Node2D
class_name CharacterSelect
@export var game_mode_list_resource: GameModesList
@export var grid_item_scene: PackedScene

var all_char: Array[CharacterModeResource]
var all_modes: Array[GameMode]
var selected_mode: GameMode
var selected_chars: Array
var current_team_id: int = 0
var teams_full: bool = false
var team_size: int = 2
var number_of_teams: int = 2

@export var selection_grid_container: HBoxContainer
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
		teams_full = false
		print("CharacterSelect: character grid freed")
	for char in resource.all_char:
		var new_item = grid_item_scene.instantiate()
		new_item.resource = char
		characters_grid.add_child(new_item)

func char_selected(resource):
	if current_team_id < number_of_teams:
		if current_team_id > len(selected_chars)-1:
			selected_chars.append([])
		if  resource not in selected_chars[current_team_id] and len(selected_chars[current_team_id]) < team_size:
			selected_chars[current_team_id].append(resource)
		if len(selected_chars[current_team_id]) >= team_size:
			current_team_id += 1
			if current_team_id >= number_of_teams:
				teams_full = true
			
		print("CharacterSelect: ", resource.name, " added to character selection")

func select(resource: Resource):
	if resource is GameMode:
		game_mode_selected(resource)
	elif resource is CharacterModeResource:
		char_selected(resource)
			
	print("CharacterSelect: selected mode,chars = ", selected_mode.name," teams: " ,selected_chars)

func _process(delta):
	if selected_mode and teams_full:
		continue_button.show()
	else:
		continue_button.hide()
	var selection_grids = selection_grid_container.get_children()
	
	if selected_chars:
		for i in range(len(selected_chars)):
			for child in selection_grids[i].get_children():
				child.queue_free()
			for char in selected_chars[i]:
				var new_item = grid_item_scene.instantiate()
				new_item.resource = char
				selection_grids[i].add_child(new_item)

func _on_continue_button_pressed():
	get_parent().create_game_instance(selected_chars, selected_mode)
	queue_free()
