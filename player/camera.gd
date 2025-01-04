extends Node3D

@export var is_paused: bool

@export_group("references")
@export var look_rot: Vector2
@export var player_body: Node3D

func _ready():
	GameManager.player_camera = self

func _physics_process(_delta: float):
	player_body.rotation_degrees.y = look_rot.y
	rotation_degrees.x = look_rot.x


func _input(event):
	if is_paused:
		return

	if event is InputEventMouseMotion:
		if Settings.invert_x:
			look_rot.x += (event.relative.y * Settings.x_sensitivity)
		else:
			look_rot.x -= (event.relative.y * Settings.x_sensitivity)
			
		if Settings.invert_x:
			look_rot.y += (event.relative.x * Settings.x_sensitivity)
		else:
			look_rot.y -= (event.relative.x * Settings.x_sensitivity)
		
		look_rot.x = clamp(look_rot.x, -85, 85)
