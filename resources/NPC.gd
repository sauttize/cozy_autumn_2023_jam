extends Resource
class_name NPC

@export var npc_name : String = "-"
@export var current_interaction : Interaction
@export var current_mission : Mission
@export_subgroup("Portraits", "pic_")
@export var pic_neutral : Texture2D
@export var pic_happy : Texture2D
@export var pic_angry : Texture2D
@export var pic_sad: Texture2D
@export var pic_doubtful : Texture2D
@export var pic_surprised : Texture2D

func get_portrait(emotion : DialogueLine.EMOTION) -> Texture2D:
	var portrait := pic_neutral
	
	match emotion:
		DialogueLine.EMOTION.HAPPY:
			if pic_happy: portrait = pic_happy
		DialogueLine.EMOTION.ANGRY:
			if pic_angry: portrait = pic_angry
		DialogueLine.EMOTION.SAD:
			if pic_sad: portrait = pic_sad
		DialogueLine.EMOTION.DOUBTFUL:
			if pic_doubtful: portrait = pic_doubtful
		DialogueLine.EMOTION.SURPRISED:
			if pic_surprised: portrait = pic_surprised
	
	return portrait

func get_name_bold() -> String:
	return "[b]%s[/b]" % npc_name
