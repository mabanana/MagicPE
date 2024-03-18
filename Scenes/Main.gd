extends Node2D
class_name MainRoot

@export var game_manager: GameManager
@export var start_button: Button
@export var menu_label: Label
@export var oid_label: Label
@export var main_menu: CanvasLayer

var game_started: bool = false
var oid: String
var network_mode: int = 0

func game_start(start = true):
	game_started = start
	if game_started:
		main_menu.hide()
	else:
		main_menu.show()
		
		
func _ready():
	change_oid()
	menu_label.text = "Magic Highschool P.E."

func _unhandled_key_input(event):
	if event.is_action_released("ui_cancel") and game_started:
		pass

func _on_quit_pressed():
	if game_started:
		get_node("GameManager").get_child(0).queue_free()
	else:
		get_tree().free()

func _on_option_button_item_selected(index):
	network_mode = index

func change_oid(new_oid = ""):
	oid = new_oid
	oid_label.text = "OID: %s" % oid
	
func _join_oid_changed(new_oid):
	if new_oid:
		start_button.text = "Join Game"
	else:
		start_button.text = "Host Game"
