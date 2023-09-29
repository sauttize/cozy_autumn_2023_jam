extends InteractOption
## Talk option
## Opens a dialogue box and shows dialogue associated with currrent "interaction" of related NPC

@export_category("Talk option")
@export var npc : NPC
var dialogue_box : PackedScene = preload("res://ui/dialogue_box.tscn")

func action():
	if !npc:
		push_error("NPC missing in %s" % self.name)
	else:
		var new_dialoguebox = dialogue_box.instantiate() as DialogueBox
		new_dialoguebox.npc = npc
		add_child(new_dialoguebox)
