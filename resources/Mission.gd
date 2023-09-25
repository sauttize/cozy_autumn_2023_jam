extends Resource
class_name Mission

@export var mission_name : String = ""
@export var items : Array[MissionItem]
@export_multiline var description : String
@export var done : bool = false
@export var icon : Texture2D
@export var made_by : NPC
