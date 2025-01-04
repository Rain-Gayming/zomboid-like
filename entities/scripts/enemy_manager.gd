class_name EnemyManager
extends Node


@export var current_health: float

@export var tag: int


func _ready():
	SignalManager.collect_tag.connect(return_tag)

func return_tag():
	SignalManager.emit_return_tag(tag)

func take_damage(damage: float):
	current_health -= damage

	if current_health <= 0:
		self.queue_free()
		SignalManager.emit_update_tag(tag)