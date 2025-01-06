extends Node

@export_group("sprite")
@export var sprite: Texture2D
@export var sprite_display: Sprite3D

@export var tag: int

@export_group("audio")
@export var pickup_effects: Array[AudioStreamPlayer3D]

func _ready():
	sprite_display.texture = sprite

func _on_collision_area_area_entered(area: Area3D) -> void:
	if area.get_parent().has_method("add_tag"):
		
		var random_play = randi_range(0, pickup_effects.size() - 1)
		pickup_effects[random_play].play()
		print(pickup_effects[random_play])
		
		area.get_parent().add_tag(tag)
		print(name + ": has been picked up")
		self.queue_free()
