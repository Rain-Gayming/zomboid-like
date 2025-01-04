extends Node3D

enum Condition
{
	enemies_killed,
	collection
}

@export var condition: Condition
@export var has_met_condition: bool

@export_group("move direction")
@export var move_up: bool
@export var move_down: bool

@export_group("kill condition")
@export var kill_tag: int
@export var kills_left: int

@export_group("collection condition")
@export var collection_tag: int

func _ready():
	SignalManager.update_tag.connect(update_tag)
	SignalManager.return_tag.connect(collect_tags)

func _process(delta: float):
		
	if has_met_condition:
		move(delta)

func collect_tags(tag: int):
	if tag == kill_tag and condition == Condition.enemies_killed:
		kills_left += 1
		print(name + ": has collected a kill tag")

func update_tag(tag: int):
	if tag == kill_tag:
		kills_left -= 1

		if kills_left == 0:
			has_met_condition = true
			print(name + ": all enemies killed, opening")

	if tag == collection_tag:
		has_met_condition = true
		print(name + ": item " + str(tag) + " has been collected, opening")


func move(delta):
	if move_up:
		var start_y = position.y
		var new_pos_y = lerp(position.y, start_y + scale.y, delta)
		position.y = new_pos_y