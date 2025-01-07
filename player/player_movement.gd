extends CharacterBody3D

@export var players_tags: Array[int]

@export_group("ground movement")
@export var current_speed: float
@export var walk_speed: float
@export var run_speed: float
@export var sprint_speed: float
@export var crouch_speed: float
@export var acceleration: float

@export_group("jumping")
@export var jump_height: float
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if Input.is_action_just_pressed("movement_jump") and is_on_floor():
		velocity.y = jump_height
	
	ground_movement(delta)
	move_and_slide()
	
func ground_movement(delta: float):
	var input_direction = Input.get_vector("movement_right", "movement_left", "movement_backward", "movement_forward")
	var direction = (transform.basis * Vector3(input_direction.x, 0, input_direction.y)).normalized()

	if direction != Vector3.ZERO:
		SignalManager.emit_noise(position, 20)

	#slows down the player when moving backwards
	if input_direction.y > 0.001:
		if direction:
			#the quartering is so the player is slower moving left and right
			velocity.x = lerp(velocity.x, (direction.x * current_speed) / 1.5, acceleration * delta)
			velocity.z = lerp(velocity.z, direction.z * current_speed, acceleration * delta)
		else:
			velocity.x = lerp(velocity.x, 0.0, acceleration * delta)
			velocity.z = lerp(velocity.z, 0.0, acceleration * delta)
	else:
		if direction:
			velocity.x = lerp(velocity.x, (direction.x * current_speed) / 2, acceleration * delta)
			velocity.z = lerp(velocity.z, (direction.z * current_speed) / 2, acceleration * delta)
		else:
			velocity.x = lerp(velocity.x, 0.0, acceleration * delta)
			velocity.z = lerp(velocity.z, 0.0, acceleration * delta)

func add_tag(tag: int):
	players_tags.append(tag)
	SignalManager.emit_update_tag(tag)