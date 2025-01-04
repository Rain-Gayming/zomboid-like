extends Node

@export var is_in_game: bool = true
@export var is_paused: bool
func _process(_delta):
	if is_in_game and !is_paused:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE