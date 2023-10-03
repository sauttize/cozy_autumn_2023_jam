extends CharacterBody2D
class_name Player

@export_category("Flags")
@export var allow_diagonal_mov : bool = false
@export var running : bool = false
@export var disable_movement : bool = false
@export_category("Attributes")
@export var speed : float = 20 :
	get:
		if !running:
			return speed * 100
		else:
			return speed * 100 * 1.3
@export var acceleration : float = 10
@export var friction : float = 5
@export_subgroup("Interaction")
@export var interaction_area : Area2D
var interactable_body : Interactable
@export_subgroup("Markers")
@export var left_marker : Marker2D
@export var right_marker : Marker2D
@export var up_marker : Marker2D
@export var down_marker : Marker2D

func _ready() -> void:
	interaction_area.body_entered.connect(body_detected)
	interaction_area.body_exited.connect(body_left)
	
	GM.PLAYER = self

func _physics_process(delta: float) -> void:
	if disable_movement: return
	if GM.busy : return
	
	var input := Input.get_vector("left", "right", "up", "down")
	running = Input.is_action_pressed("run")
	
	if input == Vector2.ZERO:
		velocity = velocity.move_toward(Vector2(0,0), friction)
	elif allow_diagonal_mov:
		velocity = velocity.move_toward(input * speed * delta, acceleration)
	else:
		if input.x != 0:
			velocity = velocity.move_toward(Vector2(input.x, 0) * speed * delta, acceleration)
		else:
			velocity = velocity.move_toward(Vector2(0, input.y) * speed * delta, acceleration)
	
	if input.y < 0:
		$AnimationPlayer.play("walk_up")
		interaction_area.transform = up_marker.transform
	elif input.y > 0:
		$AnimationPlayer.play("walk_down")
		interaction_area.transform = down_marker.transform
	else:
		$AnimationPlayer.play("idle_down")
	
	move_and_slide()

func body_detected(body : Node2D) -> void:
	if body.has_method("get_interactable"):
		interactable_body = body.get_interactable()
	elif body is Interactable:
		interactable_body = body

func body_left(_body) -> void:
	interactable_body = null

func _input(event: InputEvent) -> void:
	# Interactable handles the input
	if interactable_body: interactable_body.interact(event)
