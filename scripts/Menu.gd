extends CanvasLayer
class_name Menu

@export var animation_sequence : AnimationSequence
@export var no_delay : bool = true

func _ready() -> void:
	if no_delay: animation_sequence.delay_beginning = 0
	animation_sequence.reset_anim()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu"):
		if self.visible && animation_sequence.finished: 
			self.hide()
			animation_sequence.reset_anim()
			GM.not_busy()
		elif animation_sequence.finished && !GM.is_busy():
			animation_sequence.play_sequence()
			await animation_sequence.started 
			self.show()
			GM.make_busy()
