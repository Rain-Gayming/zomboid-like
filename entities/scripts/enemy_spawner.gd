extends Node3D

@export var spawn_visual: Node3D
@export var my_tag: int
@export var entity_to_spawn: PackedScene
@export var spawned_entity: EnemyManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.spawn.connect(spawn)
	spawn_visual.visible = false
	true_spawn()

func spawn(tag: int):
	if tag == my_tag and spawned_entity != null:
		spawned_entity.activated = true
		
	
func true_spawn():
	var new_entity = entity_to_spawn.instantiate()
	new_entity.tag = my_tag
	spawned_entity = new_entity
	self.add_child(new_entity)
