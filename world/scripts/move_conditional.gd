extends Node3D

enum Condition
{
	enemies_killed,
	collection
}

@export var condition: Condition
@export var condition_tag: int
@export var has_met_condition: bool
@export var return_condition: Condition
@export var return_tag: int
@export var has_met_return_condition: bool

@export_group("move direction")
@export var move_to: Node3D
@export var start_at: Node3D

@export_group("kill condition")
@export var kills_left: int


func _ready():
	SignalManager.update_tag.connect(update_tag)
	SignalManager.return_tag.connect(collect_tags)

func _process(delta: float):
		
	if has_met_condition and !has_met_return_condition:
		move(delta)
	if has_met_return_condition:
		reset(delta)

func collect_tags(tag: int):
	if tag == condition_tag and condition == Condition.enemies_killed:
		kills_left += 1
		print(name + ": has collected a kill tag")
		
	if tag == return_tag and return_condition == Condition.enemies_killed:
		kills_left += 1
		print(name + ": has collected a kill tag")

func update_tag(tag: int):
	if tag == condition_tag && condition == Condition.enemies_killed:
		kills_left -= 1
		print(name + ": enemy killed")

		if kills_left == 0:
			set_condition_met()
			print(name + ": all enemies killed")

	if tag == condition_tag:
		set_condition_met()
		print(name + ": item " + str(tag) + " has been  collected")

func set_condition_met():
	if !has_met_condition:
		has_met_condition = true
		condition_tag = return_tag
		condition = return_condition
	else:
		has_met_condition = false
		has_met_return_condition = true

func move(delta):
	var new_pos_y = lerp(position.y, move_to.position.y, delta)
	position.y = new_pos_y


func reset(delta):
	var new_pos_y = lerp(position.y, start_at.position.y, delta)
	position.y = new_pos_y