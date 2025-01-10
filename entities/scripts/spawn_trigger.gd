extends Node3D

@export var spawn_visual: Node3D
@export var tag: int

func _ready():    
	spawn_visual.visible = false

func _on_area_area_entered(_area: Area3D) -> void:
	if _area.is_in_group("player"):
		SignalManager.emit_spawn(tag)
