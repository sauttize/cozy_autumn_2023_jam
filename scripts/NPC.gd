@tool
extends CharacterBody2D
class_name NotPlayableCharacter

enum DIRECTION {UP, DOWN, RIGHT, LEFT}

@export_category("Resources")
@export var npc : NPC
@export_category("Nodes")
@export var interactable : Interactable
@export var is_interactable : bool = true:
	set(value):
		update_configuration_warnings()
		is_interactable = value
@export_category("Attributes")
@export var options_visible : bool :
	get:
		if interactable: return interactable.visible
		else: return false
#@export var looking_at : DIRECTION = DIRECTION.DOWN

func _ready() -> void:
	child_entered_tree.connect(update_warning)
	child_exiting_tree.connect(update_warning)
	
	if !is_interactable: return
	for node in get_children():
		if node is Interactable: interactable = node

func get_interactable() -> Interactable:
	if !is_interactable: push_error("get_interactable() called on NPC with no interactions.")
	for node in get_children():
		if node is Interactable: return node
	return null

func update_warning(_node) -> void:
	update_configuration_warnings()

func _get_configuration_warnings() -> PackedStringArray:
	if !is_interactable:
		return []
	else:
		for node in get_children():
			if node is Interactable: return []
		return ["NPC missing Interactable node."]

