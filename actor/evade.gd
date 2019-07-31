extends "res://actor/base.gd"

onready var root = $"../.."
onready var player = $"../../AnimationPlayer"
onready var sprite = $"../../Sprite"
onready var fsm = $".."

export var SPEED = 700
export var DURATION = 0.5

var life_co = null
var speed = null

func enter(arg):
	#player.play("twohand_motion_dash")
	var dir = fsm.direction(.get_input_direction().x)
	speed = Vector2(SPEED * dir, 0)
	life_co = life()

func update(dt):
	root.speed = root.update_motion(dt, speed, Vector2())	

func life():
	# Turn on invincibility or something :P
	yield(get_tree().create_timer(DURATION), "timeout")
	emit_signal("finished", "idle")