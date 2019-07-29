extends KinematicBody2D

var speed = Vector2(0, 0)
export var JUMP_TIME = 0.20
export var JUMP_HEIGHT = 50

var JUMP_SPEED = 2 * JUMP_HEIGHT / JUMP_TIME
var JUMP_GRAVITY = -JUMP_SPEED / (2 * JUMP_TIME)

func update_motion(dt, speed, gravity=Vector2(0, -JUMP_GRAVITY)):
	speed = apply_gravity(dt, speed, gravity)
	speed = move_and_slide(speed, Vector2(0, -1))
	if is_on_floor():
		speed.y = 0
	if is_on_wall():
		speed.x = 0
	return speed

func apply_gravity(dt, speed, gravity):
	return speed + gravity * dt