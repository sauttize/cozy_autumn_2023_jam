extends InteractOption
## Talk option
## Opens a dialogue box and shows dialogue associated with currrent "interaction" of related NPC

@export_category("Talk option")
@export var npc : NPC
var interaction : Interaction

func _ready() -> void:
	if npc:
		get_interaction()

func action():
	if !interaction and npc:
		get_interaction()
	elif !npc:
		push_error("NPC missing in %s" % self.name)
		return
	
	# stuff with interaction...

func get_interaction():
	interaction = npc.current_interaction
