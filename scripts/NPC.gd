extends CharacterBody2D
class_name NotPlayableCharacter

enum DIRECTION {UP, DOWN, RIGHT, LEFT}

@export_category("Resources")
@export var npc : NPC
@export_category("Nodes")
@export var area_nodes : Array[Area2D]
@export var interact_options : Node2D
@export_category("Attributes")
@export var in_area : bool = false ## If player is in area
@export var options_visible : bool :
	get:
		return interact_options.visible
@export var looking_at : DIRECTION = DIRECTION.DOWN

