@tool
extends Node
class_name AnimationSequence

@export var animationPlayer : AnimationPlayer:
	set(node):
		animationPlayer = node
		update_configuration_warnings()
@export var animation_sequence : Array[String]
@export var delay_beginning : float = 0
@export var delay_between : float = 0.1
var finished : bool = true
@export_subgroup("Options")
@export var play_at_ready : bool = false
@export var use_same_delay : bool = true
@export var delay_list : Array[float]
@export var loop : bool = false
@export_subgroup("Testing")
@export var test : bool = false
@export var reset : bool = false

signal started

func _ready() -> void:
	update_configuration_warnings()
	if play_at_ready: play_sequence()

func play_sequence() -> void:
	test = false
	finished = false
	if !animationPlayer or animation_sequence.is_empty(): return
	await get_tree().create_timer(delay_beginning).timeout
	for index in range(animation_sequence.size()):
		## Play:
		if animationPlayer.has_animation(animation_sequence[index]):
			animationPlayer.play(animation_sequence[index])
			await get_tree().create_timer(0.1).timeout
			started.emit()
		else:
			push_error("Animation named '%s' not found." % animation_sequence[index])
		## Delay:
		if use_same_delay:
			await get_tree().create_timer(delay_between).timeout
		else:
			await get_tree().create_timer(delay_list[index]).timeout
	finished = true

func reset_anim() -> void:
	reset = false
	animationPlayer.play("RESET")

func _process(_delta: float) -> void:
	if test:
		play_sequence()
	if reset:
		reset_anim()

func _get_configuration_warnings() -> PackedStringArray:
	if !animationPlayer:
		return ["Animation player needed"]
	else:
		return []
