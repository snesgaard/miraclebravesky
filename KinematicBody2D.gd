extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const GRAVITY = Vector2(0, 500)

var vel = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if not event is InputEventKey:
		return
	if event.scancode == KEY_A:
		print("foo")

func _physics_process(dt):
	if Input.is_key_pressed(KEY_RIGHT):
		vel.x = 200
	elif Input.is_key_pressed(KEY_LEFT):
		vel.x = -200
	else:
		vel.x = 0
	vel += GRAVITY * dt
	var info = move_and_collide(vel * dt)
	if info and info.normal.dot(Vector2(0, -1)) > 0.9:
		vel.y = min(0, vel.y)
		if Input.is_key_pressed(KEY_SPACE):
			vel.y = -200
	