extends Node3D

@export_group("conditions")
@export var conditions: Array[Condition]
@export var conditions_completed: int
@export var sequal_conditions: int
@export var condition_amount: int

@export_group("move direction")
@export var move_to: Node3D
@export var start_at: Node3D

func _ready():
	for con in conditions:
		condition_amount += 1
		if con.run_after_last:
			sequal_conditions += 1

	SignalManager.update_tag.connect(update_tag)
	SignalManager.return_tag.connect(collect_tags)
	

func _process(delta: float):
	if conditions_completed >= condition_amount - sequal_conditions:
		move(delta)
	
	if conditions_completed >= condition_amount and sequal_conditions != 0:
		reset(delta)

func collect_tags(tag: int):
	for con in conditions:
		if con.tag == tag:
			con.amount += 1

func update_tag(tag: int):
	for con in conditions:
		if con.condition == 1 and con.tag == tag:
			con.has_been_completed = true
			print("item needed for the door has been collected")

		if con.tag == tag:
			con.amount -= 1
			if con.amount <= 0:
				con.has_been_completed = true

		check_conditions()

func check_conditions():
	for con in conditions:
		if con.has_been_completed:
			conditions_completed += 1
			conditions.remove_at(conditions.find(con))


func move(delta):
	var new_pos_y = lerp(position.y, move_to.position.y, delta)
	position.y = new_pos_y


func reset(delta):
	var new_pos_y = lerp(position.y, start_at.position.y, delta)
	position.y = new_pos_y