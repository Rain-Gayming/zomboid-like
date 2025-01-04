class_name InputTaker
extends Node3D

@export var should_pause: bool
@export var can_take_inputs: bool

func _ready():
	GameManager.input_takers.append(self)