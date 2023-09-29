extends Resource
class_name Dialogue

@export var lines : Array[DialogueLine]:
	get: 
		if !allow_alt: return lines
		elif randi() % 2 == 0:
			return alt_lines
		else:
			return lines
@export_subgroup("Alternative content")
@export var allow_alt : bool = false
@export var alt_lines : Array[DialogueLine]

func _init(text : String = "-") -> void:
	var line := DialogueLine.new(text)
	lines.append(line)
