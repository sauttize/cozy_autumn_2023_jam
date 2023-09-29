extends Node

var PLAYER : Player
var showing_dialogue : bool = false

func enable_movement() -> void:
	PLAYER.disable_movement = false

func disable_movement() -> void:
	PLAYER.disable_movement = true
