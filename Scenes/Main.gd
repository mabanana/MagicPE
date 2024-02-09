extends Node2D
class_name MainRoot

@export var game_manager: GameManager
var is_paused: bool = true


func _ready():
	get_tree().paused = true


func _unhandled_key_input(event):
	print("Main: unhandled input detected, tree paused is ", is_paused)
	if event.is_action_released("ui_cancel") and game_manager.has_node("GameInstance"):
		toggle_pause()

func toggle_pause(toggle_to = null):
	if toggle_to:
		get_tree().paused = toggle_to
		is_paused = toggle_to
	else:
		get_tree().paused = not get_tree().paused
		is_paused = get_tree().paused
	print("GameManager: Pause is toggled to ", is_paused)
