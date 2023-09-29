extends CanvasLayer
class_name DialogueBox

@export_category("Dependencies")
@export_subgroup("Resources")
@export var npc : NPC
var inter : Interaction
var dialogue : Dialogue
@export_subgroup("Nodes")
@onready var name_text : RichTextLabel = %npcName
@onready var dialog_text : RichTextLabel = %dialog
@onready var npc_pic : TextureRect = %picture
@export_category("Attributes")
var lines : Array[DialogueLine]
var current_line : DialogueLine:
	get: 
		return lines[current_ind]
var current_ind : int = 0 :
	get:
		return clamp(current_ind, 0, lines.size() - 1)
var line_finished : bool = false
var skipped : bool = false
@export_range(0.001, 2.) var char_delay : float = 0.02
@export_range(0.001, 2.) var char_delay_skipped : float = 0.01
@export_range(0.001, 1.) var ratio_add : float = 0.03 
@export_range(0.001, 1.) var ratio_add_skipped : float = 0.1 

func _init(new_npc : NPC = NPC.new()) -> void:
	if !npc: npc = new_npc

func _ready() -> void:
	start()

func _input(event: InputEvent) -> void:
	if event.is_action_released("interact"):
		if line_finished:
			if current_ind == lines.size() - 1:
				stop()
			else:
				current_ind += 1
				show_text(current_line.content)
		else:
			skipped = true

func start() -> void:
	GM.disable_movement()
	GM.showing_dialogue = true
	clear_text(true)
	name_text.append_text(npc.get_name_bold())
	
	inter = npc.current_interaction
	dialogue = inter.dialogues[inter.index]
	
	lines = dialogue.lines
	show_text(lines[0].content)

func stop() -> void:
	inter.interaction_done()
	if inter.finished && inter.give_mission:
		## Se encarga de dar la mision
		pass 
	if inter.finished:
		if !inter.need_mission || inter.need_mission.done:
			if inter.next_interaction:
				npc.current_interaction = inter.next_interaction
	
	GM.enable_movement()
	GM.showing_dialogue = false
	queue_free()

func show_text(text : String) -> void:
	clear_text()
	update_portrait()
	dialog_text.append_text(text)
	dialog_text.visible_ratio = 0
	line_finished = false
	while (dialog_text.visible_ratio != 1):
		await get_tree().create_timer(char_delay if !skipped else char_delay_skipped).timeout
		var current = dialog_text.visible_ratio
		current += ratio_add if !skipped else ratio_add_skipped
		dialog_text.visible_ratio = clamp(current, 0, 1)
	line_finished = true
	skipped = false

func update_portrait() -> void:
	npc_pic.texture = npc.get_portrait(current_line.emotion)

#func apply_shake() ->  void:
#func apply_side_to_side() -> void:

func show_icon() -> void:
	# Shows an icon to make clear that there is more text
	pass

func clear_text(all : bool = false):
	dialog_text.clear()
	if all:
		name_text.clear()
