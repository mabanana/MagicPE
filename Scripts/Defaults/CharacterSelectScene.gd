extends Node2D
class_name CharacterSelect
@export var char_mode_resource: ResourceDict
@export var grid_item_scene: PackedScene

var all_char: Array[CharacterResource]
var all_modes: Array[GameMode]
var selected_mode: GameMode
var selected_chars: Array[CharacterResource]

@export var characters_grid: GridContainer
@export var game_modes_grid: GridContainer
@export var continue_button: Button

func _ready():
	continue_button.hide()
	all_modes = char_mode_resource.game_modes 
	all_char = char_mode_resource.characters
	for mode in all_modes:
		var new_item = grid_item_scene.instantiate()
		new_item.resource = mode
		game_modes_grid.add_child(new_item)
	for char in all_char:
		var new_item = grid_item_scene.instantiate()
		new_item.resource = char
		characters_grid.add_child(new_item)

func select(resource: Resource):
	if resource is GameMode:
		selected_mode = resource
		print("CharacterSelect: ", resource.name, " added to mode selection")
	elif resource is CharacterResource:
		if resource not in selected_chars:
			selected_chars.append(resource)
			print("CharacterSelect: ", resource.name, " added to character selection")
	print("CharacterSelect: selected mode,chars = ", selected_mode, selected_chars)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if selected_mode and len(selected_chars) > 0:
		continue_button.show()


func _on_continue_button_pressed():
	get_parent().create_game_instance(selected_chars, selected_mode)
	queue_free()
