extends Node
class_name GameManager

@export var game_instance_scene: PackedScene
@export var character_select_scene: PackedScene

func create_game_instance(characters:Array[CharacterResource], game_mode:GameMode):
	var game_instance = game_instance_scene.instantiate()
	game_instance.game_mode = game_mode
	game_instance.characters = characters
	add_child(game_instance)

func create_character_select_instance():
	var new_scene = character_select_scene.instantiate()
	add_child(new_scene)


func _on_start_pressed():
	print("GameManager: Start Button Pressed")
	create_character_select_instance()
	get_parent().toggle_pause(false)
