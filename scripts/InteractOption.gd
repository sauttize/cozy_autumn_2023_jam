extends Node2D
class_name InteractOption

@export var option_name : String
@export_category("Animations")
var pos_tween : PositionTween
var pos_tween2 : PositionTween
var alpha_tween : AlphaTween
# Positions
var center : Vector2 = Vector2.ZERO
var pos_up : Vector2 = Vector2(0, -10)
var pos_down : Vector2 = Vector2(0, 10)
var pos_left : Vector2 = Vector2(-15, 0)
var pos_right : Vector2 = Vector2(15, 0)

func _ready() -> void:
#	hide()
	for node in get_children(true):
		if node is Label: node.text = option_name
		if node is PositionTween: 
			if !pos_tween:
				pos_tween = node
				pos_tween.node = self
			else:
				pos_tween2 = node
				pos_tween2.node = self
		if node is AlphaTween: 
			alpha_tween = node
			alpha_tween.node = self
	
	play_shake()

func action():
	pass

func play_anim_down(shows : bool = false) -> void:
	if !pos_tween || !alpha_tween: 
		push_error("Tweens not found")
		return
	
	alpha_tween.fromAplhaValue = 0 if shows else 1
	alpha_tween.toAplhaValue = 1 if shows else 0
	
	pos_tween.fromPosition2D = pos_up if shows else center
	pos_tween.toPosition2D = center if shows else pos_down
	
	pos_tween.play_Tween()
	alpha_tween.play_Tween()
	
	await alpha_tween.tween_finished

func play_anim_up(shows : bool = false) -> void:
	if !pos_tween || !alpha_tween: 
		push_error("Tweens not found")
		return
	
	alpha_tween.fromAplhaValue = 0 if shows else 1
	alpha_tween.toAplhaValue = 1 if shows else 0
	
	pos_tween.fromPosition2D = pos_down if shows else center
	pos_tween.toPosition2D = center if shows else pos_up
	
	pos_tween.play_Tween()
	alpha_tween.play_Tween()
	
	await alpha_tween.tween_finished

func play_shake() -> void:
	pos_tween.parallelToNext = false
	
	pos_tween.duration = 0.08
	pos_tween.transitionType = Tween.TRANS_SPRING
	pos_tween.fromPosition2D = center
	pos_tween.toPosition2D = pos_left
	
	pos_tween2.fromPosition2D = pos_left
	pos_tween2.toPosition2D = pos_right
	
	await pos_tween.play_Tween()
	await pos_tween2.play_Tween()
	
	pos_tween.fromPosition2D = pos_right
	pos_tween.toPosition2D = center
	
	pos_tween.play_Tween()
	

#func _input(event: InputEvent) -> void:
#	if event.is_action_pressed("ui_up"):
#		play_anim_up()
#	if event.is_action_pressed("ui_down"):
#		play_anim_down()
#	if event.is_action_pressed("up"):
#		play_anim_up(true)
#	if event.is_action_pressed("down"):
#		play_anim_down(true)
