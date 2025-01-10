extends Node3D

@export var spawn_visual: Node3D
@export var my_tag: int
@export var entity_to_spawn: PackedScene
@export var has_spawned: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_visual.visible = false
	SignalManager.spawn.connect(spawn)

func spawn(tag: int):
	if tag == my_tag and not has_spawned:
		print("tag found")
		has_spawned = true
		var new_entity = entity_to_spawn.instantiate()
		new_entity.tag = my_tag
		self.add_child(new_entity)
		print(new_entity)