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

func _physics_process(dt):
	vel += GRAVITY * dt
	var info = move_and_slide(vel)
	print(info)
