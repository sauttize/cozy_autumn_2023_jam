extends Node
class_name PositionTween

#Tween
@export var node : Node
@export_category("Tween")
@export var startAtReady : bool = true
@export var parallelToNext : bool = false
@export_range(0, 10) var duration : float = 1.5
@export var easeType : Tween.EaseType = Tween.EASE_IN_OUT
@export var transitionType : Tween.TransitionType = Tween.TRANS_BACK
@export var newStartingPosition : bool = false
@export var fromPosition2D : Vector2 = Vector2(0, 0)
@export var toPosition2D : Vector2 = Vector2(0, 0)

signal tween_finished

func _ready():
	if(node && startAtReady):
		play_Tween()
	elif (startAtReady): 
		print("Node not assign in Tween Animation.")
		print(get_path())

func play_Tween():
	var tween = create_tween().set_ease(easeType).set_trans(transitionType)
	if parallelToNext: tween.parallel()
	if(newStartingPosition):
		tween.tween_property(node, "position", toPosition2D, duration).from(fromPosition2D)
	else:
		tween.tween_property(node, "position", toPosition2D, duration)
	await get_tree().create_timer(duration).timeout
	tween_finished.emit()
