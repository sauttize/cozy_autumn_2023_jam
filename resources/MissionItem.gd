extends Resource
class_name MissionItem

@export_multiline var description : String
@export var quantity : int = 0
@export_subgroup("Waiting for...")
@export var item : Item
@export var mission : Mission
@export var event : Event
