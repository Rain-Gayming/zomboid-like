extends Node3D

@export_group("refereences")
@export var anim: AnimatedSprite3D

@export_group("shooting")
@export var shoot_cooldown: float
@export var shoot_timer: float
@export var shoot_from: RayCast3D
@export var shoot_range: float

@export_group("stats")
@export var anim_name: String
@export var damage: float

func _ready():
	shoot_from.target_position.y = -shoot_range
	anim.play(anim_name + "_idle")

func _process(delta):
	if shoot_cooldown > 0:
		shoot_cooldown -= delta

	if Input.is_action_just_pressed("combat_shoot") and shoot_cooldown <= 0:
		shoot()
	
	#if the shooting animation is finished, play the idle animation
	if anim.animation == anim_name + "_shoot":
		if anim.frame == 12:
			anim.play(anim_name + "_idle")

func shoot():
	shoot_timer = shoot_cooldown
	anim.play(anim_name + "_shoot")

	#raycasting
	if shoot_from.is_colliding():
		var hit = shoot_from.get_collider()
		if hit.has_method("take_damage"):
			hit.take_damage(damage)