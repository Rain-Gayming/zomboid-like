extends Node3D

@export var spawn_visual: Node3D
@export var tag: int

func _ready():    
	spawn_visual.visible = false

func _on_area_area_entered(_area: Area3D) -> void:
	SignalManager.emit_spawn(tag) 
