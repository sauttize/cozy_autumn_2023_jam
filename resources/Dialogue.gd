extends Resource
class_name Dialogue

@export_multiline var content : String
@export_subgroup("Alternative content")
@export var allow_alt : bool = false
@export_multiline var alt_content : String
