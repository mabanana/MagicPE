extends Node2D
class_name MainRoot

@export var game_manager: GameManager
var is_paused: bool = true
var game_started: bool = false
@export var start_button: Button
@export var menu_label: Label

func hide_start_button(hide = true):
	if hide:
		start_button.hide()
	else:
		start_button.show()

func game_start(start = true):
	if start:
		menu_label.text = "Paused"
	else:
		menu_label.text = "Magic Highschool P.E."
	game_started = start
	
	
func _ready():
	get_tree().paused = true
	menu_label.text = "Magic Highschool P.E."

func _unhandled_key_input(event):
	if event.is_action_released("ui_cancel") and game_started:
		toggle_pause()

func toggle_pause(toggle_to = null):
	if toggle_to:
		get_tree().paused = toggle_to
		is_paused = toggle_to
	else:
		get_tree().paused = not get_tree().paused
		is_paused = get_tree().paused
	print("GameManager: Pause is toggled to ", is_paused)


func _on_quit_pressed():
	if game_started:
		get_node("GameManager").get_child(0).queue_free()
	else:
		get_tree().free()
