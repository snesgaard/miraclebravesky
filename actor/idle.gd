extends "res://actor/base.gd"

onready var root = $"../.."
onready var player = $"../../AnimationPlayer"
onready var sprite = $"../../Sprite"

export(float) var MAX_RUN_SPEED = 350
export(float) var MAX_JUMP_SPEED = 350


func enter():
	player.play("twohand_idle_full")
	root.speed.x = 0

func get_input_direction():
	var input_direction = Vector2()
	input_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	return input_direction

func update_motion(dt):
	var input_direction = get_input_direction()
	root.speed.x = MAX_RUN_SPEED * input_direction.x
	if input_direction.x != 0:
		sprite.scale.x = input_direction.x

func update(dt):
	update_motion(dt)
	update_jump(root, MAX_JUMP_SPEED)
	root.speed = root.update_motion(dt, root.speed)
	update_animation_motion(player, root)
	
	if Input.is_action_pressed("attack"):
		emit_signal("finished", "charge")
