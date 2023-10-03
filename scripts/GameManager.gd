extends Node

var PLAYER : Player
var busy : bool = false
# Cursor
var normal_cursor := load("res://ui/cursor/normal.png")
var click_cursor := load("res://ui/cursor/clicked.png")
var grab_cursor := load("res://ui/cursor/grab.png")
var stop_cursor := load("res://ui/cursor/stop_red.png")

func _ready() -> void:
	Input.set_custom_mouse_cursor(normal_cursor, Input.CURSOR_ARROW, Vector2(10, 5))
	Input.set_custom_mouse_cursor(stop_cursor, Input.CURSOR_FORBIDDEN)
	Input.set_custom_mouse_cursor(grab_cursor, Input.CURSOR_DRAG)

## General

func is_busy() -> bool:
	return busy

func make_busy() -> void:
	busy = true

func not_busy() -> void:
	busy = false

## Player

func enable_movement() -> void:
	PLAYER.disable_movement = false

func disable_movement() -> void:
	PLAYER.disable_movement = true

## Cursor
func cursor_clicked(sets : bool) -> void:
	if sets: Input.set_custom_mouse_cursor(click_cursor, Input.CURSOR_ARROW, Vector2(10, 5))
	else: Input.set_custom_mouse_cursor(normal_cursor, Input.CURSOR_ARROW, Vector2(10, 5))

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		cursor_clicked(true)
	if event.is_action_released("click"):
		cursor_clicked(false)
