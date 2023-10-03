@tool
extends Node2D
class_name Interactable

## Works alongside InteractOption. Children of this will be shown as options to select.

var selected : int = 0 ## Current option index.
var options_count : int : ## Counter of options.
	get:
		return interact_options.size()
var current_option : InteractOption:
	get: return interact_options[selected]
var interact_options : Array[InteractOption]

func _ready() -> void:
	child_entered_tree.connect(update_children)
	visibility_changed.connect(reset_attributes)
	
	update_children(null)

func interact(event: InputEvent) -> void:
	if interact_options.is_empty(): return
	if event.is_action_pressed("interact"):
		if self.visible:
			self.hide()
			current_option.action()
		elif !GM.is_busy():
			self.show()
			GM.make_busy()
	
	if !self.visible: return
	if event.is_action_released("down"):
		change_selected(false)
	elif event.is_action_released("up"):
		change_selected(true)

func change_selected(up : bool):
	# No more options animation
	if options_count == 1:
		interact_options[0].play_shake()
		return
	# Reel animation
	var index_before = selected
	if up:
		interact_options[index_before].play_anim_up()
		if selected == 0:
			selected = (interact_options.size() - 1)
		else:
			selected -= 1
		interact_options[selected].show()
		await interact_options[selected].play_anim_up(true)
		interact_options[index_before].hide()
	else:
		interact_options[index_before].play_anim_down()
		if selected >= (interact_options.size() - 1):
			selected = 0
		else: 
			selected += 1
		interact_options[selected].show()
		await interact_options[selected].play_anim_down(true)
		interact_options[index_before].hide()

func reset_attributes():
	selected = 0

func update_children(_node) -> void:
	interact_options.clear()
	for node in get_children():
		if node is InteractOption: interact_options.append(node)
		node.hide()
	if !interact_options.is_empty(): interact_options[0].show()
	update_configuration_warnings()

func _get_configuration_warnings() -> PackedStringArray:
	if get_child_count() == 0:
		return ["At least 1 InteractOption needed as child."]
	else:
		for node in get_children():
			if node is InteractOption: return []
		return ["No InteractOption found, remember to attach script."]
