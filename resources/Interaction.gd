extends Resource
class_name Interaction

@export var dialogues : Array[Dialogue]
## If not selected it will randomly choose the next dialogue to show
@export var in_order : bool = true
@export_subgroup("In order options")
## Starts over again after finishing all dialogues
@export var loop : bool = false
@export var final_dialogue : Dialogue
@export var final_mission : Mission
