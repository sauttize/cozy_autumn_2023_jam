extends Resource
class_name Interaction

@export var dialogues : Array[Dialogue]:
	get:
		if !finished || !in_order: return dialogues
		else: 
			if final_dialogue: return [final_dialogue]
			else: return[Dialogue.new("...")]
## If not selected it will randomly choose the next dialogue to show
@export var in_order : bool = true
@export var index : int = 0 :
	get:
		if in_order: return clamp(index, 0, dialogues.size() - 1)
		else: return randi_range(0, dialogues.size() - 1)
@export_subgroup("In order options")
## Starts over again after finishing all dialogues
@export var finished : bool = false
@export var loop : bool = false
@export var final_dialogue : Dialogue
@export var give_mission : Mission
@export_category("Next interaction")
@export var need_mission : Mission ## Needs this mission for it to give the next interaction
@export var next_interaction : Interaction

func interaction_done() -> void:
	if index == dialogues.size() - 1:
		if loop: index = 0
		else: finished = true
	else:
		index += 1
