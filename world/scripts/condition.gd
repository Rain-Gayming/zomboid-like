class_name Condition
extends Resource

enum ECondition
{
	enemies_killed,
	collection
}

@export var condition: ECondition
@export var tag: int
@export var has_been_completed: bool
@export var amount: int
@export var run_after_last: bool