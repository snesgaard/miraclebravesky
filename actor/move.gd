extends "res://actor/base.gd"

export(float) var MAX_WALK_SPEED = 450
export(float) var MAX_RUN_SPEED = 350

onready var root = $"../.."
onready var player = $"../../AnimationPlayer"
onready var sprite = $"../../Sprite"

func enter():
	player.play("twohand_run_run")

func get_input_direction():
	var input_direction = Vector2()
	input_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	return input_direction

func update(dt):
	var input_direction = get_input_direction()
	if input_direction.x == 0:
		emit_signal("finished", "idle")
		return
	
	root.speed.x = MAX_RUN_SPEED * input_direction.x
	root.speed = root.update_motion(dt, root.speed)
	sprite.scale.x = input_direction.x
	
	update_animation_motion(player, root)