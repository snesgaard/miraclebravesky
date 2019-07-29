extends "res://scripts/state.gd"

onready var body = $"../.."
onready var sprite = $"../../sprite"

var dir = 1

var velocity = Vector2(1200, -500)

func enter(_dir):
	dir = _dir
	body.speed = Vector2(0, 0)
	sprite.rotation = dir * PI * 0.15

func update(dt):
	body.update_motion(dt, velocity * dir)
	if body.is_on_wall():
		emit_signal("finished", "rebound", dir)