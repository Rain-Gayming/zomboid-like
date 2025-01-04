extends Node

@export var tag: int

func _on_collision_area_area_entered(area: Area3D) -> void:
	if area.get_parent().has_method("add_tag"):
		area.get_parent().add_tag(tag)
		print(name + ": has been picked up")
		self.queue_free()
