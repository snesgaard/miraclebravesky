extends KinematicBody2D

var speed = Vector2(0, 0)
export var default_gravity = Vector2(0, 1000.0)

func update_motion(dt, speed):
	speed = apply_gravity(dt, speed, default_gravity)
	speed = move_and_slide(speed, Vector2(0, -1))
	if is_on_floor():
		speed.y = 0
	if is_on_wall():
		speed.x = 0
	return speed

func apply_gravity(dt, speed, gravity):
	return speed + gravity * dt