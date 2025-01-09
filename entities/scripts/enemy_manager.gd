class_name EnemyManager
extends CharacterBody3D

@export_group("references")
@export var agent: NavigationAgent3D
@export var tag: int

@export_group("targetting")
@export var has_target: bool
@export var heard_from: Node3D
@export var can_see_target: bool
@export var last_target_seen_position: Vector3
@export var target: Vector3
@export var last_sound_heard: String
@export var last_sound_loudness: float
@export var current_action: int = -1 # -1 = no action 0 = melee 1 = ranged
var last_target: Vector3
var navigationserver_region_rid: RID = get_rid()

@export_group("stats")
@export var current_health: float
@export var melee_range: float
@export var missile_range: float
@export var move_speed: float
@export var is_ranged: bool

func _ready():
	SignalManager.collect_tag.connect(return_tag)
	SignalManager.noise.connect(heard_sound)

func _physics_process(_delta):
	if target != Vector3.ZERO :
		
		var distance_to_target = position.distance_to(target)
		var distance_to_stay

		if is_ranged:
			distance_to_stay = missile_range
		else:
			distance_to_stay = melee_range

		if distance_to_target > distance_to_stay:

			if current_action == -1:
				current_action = randi_range(0, 1)
				print(current_action)

			var current_location = global_transform.origin
			var next_location = target
			var new_velocty = (next_location - current_location).normalized() * move_speed

			velocity = new_velocty

			if distance_to_target <= distance_to_stay:
				target = Vector3.ZERO
		elif distance_to_target < distance_to_stay:
			print("moving backwards")
			var direction = position.direction_to(target)
			velocity = -direction * -move_speed
		else: 
			velocity = Vector3.ZERO
		move_and_slide()

func return_tag():
	SignalManager.emit_return_tag(tag)

func take_damage(damage: float):
	current_health -= damage

	if current_health <= 0:
		self.queue_free()
		SignalManager.emit_update_tag(tag)


func heard_sound(position_from: Vector3, loudness: float, sound_name: String):
	var distance = position_from.distance_to(position)
	if target == Vector3.ZERO or last_sound_heard == name or loudness > last_sound_loudness:
		if distance <= loudness:
			target = position_from
			agent.set_target_position(position_from)

			last_sound_heard = sound_name
			last_sound_loudness = loudness
	

func can_see(area: Area3D) -> void:
	if area.has_method("add_tag"):
		target = area.position
