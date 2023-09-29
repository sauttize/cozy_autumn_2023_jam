extends Resource
class_name DialogueLine

enum EMOTION {NEUTRAL, SAD, ANGRY, HAPPY, DOUBTFUL, SURPRISED}

@export_multiline var content : String = ""
@export var emotion : EMOTION = EMOTION.NEUTRAL
@export_subgroup("VFX")
@export var shake : bool = false
@export var side_to_side : bool = false

func _init(text : String = "-") -> void:
	content = text
