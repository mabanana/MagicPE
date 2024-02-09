extends Resource
class_name GameMode

@export var name: String

@export var game_component: PackedScene
@export var state_machine: PackedScene

@export var game_entities: Array[GameEntity]
@export var icon: Texture
