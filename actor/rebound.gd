extends "res://scripts/state.gd"

var rebound_speed = Vector2(200, -200)
onready var body = $"../.."

var _dir = 1

func enter(dir):
	_dir = dir
	body.speed = Vector2(-rebound_speed.x * dir, rebound_speed.y)
	
func update(dt):
	body.speed = body.update_motion(dt, body.speed)
	if body.is_on_floor():
		emit_signal("finished", "idle")
