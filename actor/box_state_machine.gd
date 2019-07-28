extends "res://scripts/state_machine.gd"

func _ready():
	states_map = {
		"idle": $idle,
		"thrown": $thrown,
		"rebound": $rebound
	}