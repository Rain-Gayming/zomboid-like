class_name EnemyManager
extends CharacterBody3D

@export_group("references")
@export var agent: NavigationAgent3D
@export var tag: int

@export_group("targetting")
@export var target: Node3D
@export var current_action: int = -1 # -1 = no action 0 = melee 1 = ranged
var last_target: Vector3
var navigationserver_region_rid: RID = get_rid()
@export var rotation_speed: float = 15

@export_group("stats")
@export var current_health: float
@export var melee_range: float
@export var missile_range: float
@export var move_speed: float
@export var is_ranged: bool
@export var wait_time: float
@export var wait_timer: float


func _ready():
	wait_timer = wait_time
	SignalManager.collect_tag.connect(return_tag)
	SignalManager.emit_return_tag(tag)
	target = get_tree().get_nodes_in_group("player")[0]

func _physics_process(delta):
	wait_timer -= delta
	if target != null and wait_timer <= 0:
		#rotates the enemy to the target+
		look_at(target.global_position, -transform.basis.y)

		rotation.x = 0
		rotation.z = 0
		#sets the target to the player
		
		var distance_to_target = position.distance_to(target.position)
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
			var next_location = target.position
			var new_velocty = (next_location - current_location).normalized() * move_speed

			velocity = new_velocty

			if distance_to_target <= distance_to_stay:
				target = null
		elif distance_to_target < distance_to_stay:
			print("moving backwards")
			var direction = position.direction_to(target.position)
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

