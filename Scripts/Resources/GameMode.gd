extends Resource
class_name GameMode

@export var name: String
@export var icon: Texture

@export_category("Components")
@export var game_component: PackedScene
@export var state_machine: PackedScene
@export var animation_tree: PackedScene

@export_category("Lists of all Child Entities")
@export var game_entities: Array[GameEntity]
@export var all_char: Array[CharacterModeResource]
