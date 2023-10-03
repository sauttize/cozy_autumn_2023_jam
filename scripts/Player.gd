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

func _ready() -> void:
	GM.PLAYER = self

func _physics_process(delta: float) -> void:
	if disable_movement: return
	
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
	elif input.y > 0:
		$AnimationPlayer.play("walk_down")
	else:
		$AnimationPlayer.play("idle_down")
	
	move_and_slide()
