extends Node2D
class_name Interactable

@export_category("Options")
@export var selected : int = 0
@export var selected_style : StyleBoxFlat
@export var not_selected_style : StyleBoxFlat
@export_category("Nodes")
@export var interaction_panels : Array[Panel]
@export var area_nodes : Array[Area2D]
@export_category("Attributes")
@export var in_area : bool = false ## If player is in area

func _ready() -> void:
	for area in area_nodes:
		area.body_entered.connect(body_entered_area)
		area.body_exited.connect(body_exited_area)

	update_panel_style()
	visibility_changed.connect(reset_attributes)

func _input(event: InputEvent) -> void:
	if in_area:
		if event.is_action_pressed("interact"):
			if self.visible:
				self.hide()
				GM.PLAYER.disable_movement = false
			else:
				self.show()
				GM.PLAYER.disable_movement = true
	
	if !self.visible: return
	if event.is_action_released("down"):
		change_selected(false)
	elif event.is_action_released("up"):
		change_selected(true)

func change_selected(up : bool):
	if up:
		if selected == 0:
			selected = (interaction_panels.size() - 1)
		else:
			selected -= 1
	else:
		if selected >= (interaction_panels.size() - 1):
			selected = 0
		else: 
			selected += 1
	update_panel_style()

func update_panel_style():
	for panel in interaction_panels:
		panel.add_theme_stylebox_override("panel", not_selected_style)
	
	interaction_panels[selected].add_theme_stylebox_override("panel", selected_style)

func reset_attributes():
	selected = 0
	update_panel_style()

## Areas of interaction behavior

func body_entered_area(body : Node2D):
	if body is Player:
		in_area = true

func body_exited_area(body : Node2D):
	if body is Player:
		in_area = false
