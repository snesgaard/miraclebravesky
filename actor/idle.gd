extends "res://actor/base.gd"

onready var root = $"../.."
onready var player = $"../../AnimationPlayer"
onready var sprite = $"../../Sprite"
onready var fsm = $".."

export(float) var MAX_RUN_SPEED = 350
export(float) var MAX_JUMP_SPEED = 350

var dash_ready = true

func enter(arg):
	player.play("twohand_idle_full")
	root.speed.x = 0

func update_motion(dt):
	var input_direction = .get_input_direction()
	root.speed.x = MAX_RUN_SPEED * input_direction.x
	fsm.direction(input_direction.x)
		#sprite.scale.x = input_direction.x
		#if root.scale.x != input_direction.x:
		#	root.scale.x = input_direction.x

func update(dt):
	if root.is_on_floor():
		dash_ready = true
	update_motion(dt)
	update_jump(root, root.JUMP_SPEED)
	#root.speed = root.update_motion(dt, root.speed)
	update_animation_motion(player, root)
	
	if Input.is_action_pressed("attack"):
		emit_signal("finished", "charge")
	elif Input.is_action_just_pressed("evade") and dash_ready:
		dash_ready = false
		emit_signal("finished", "evade")
