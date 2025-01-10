extends Node

@export var spawn_visual: Node3D
@export var my_tag: int
@export var entity_to_spawn: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_visual.visible = false
	SignalManager.spawn.connect(spawn)

func spawn(tag: int):
	if tag == my_tag:
		entity_to_spawn.instantiate()