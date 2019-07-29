extends "res://scripts/state.gd"

onready var sprite = $"../../sprite"
onready var body = $"../.."

func enter(arg):
	body.speed.x = 0

func update(dt):
	body.speed = body.update_motion(dt, body.speed)