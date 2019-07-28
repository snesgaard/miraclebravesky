extends "res://scripts/state.gd"


func update_animation_motion(player, body):
	var speed = body.speed
	if body.is_on_floor():
		if abs(speed.x) > 0:
			player.play("twohand_run_run")
		else:
			player.play("twohand_idle_full")
	else:
		if speed.y < 0:
			player.play("twohand_motion_ascend")
		else:
			player.play("twohand_motion_descend")
	
func update_jump(body, JUMP_SPEED):
	if body.is_on_floor() and Input.is_action_pressed("jump"):
		print("jump!!!")
		body.speed.y = -JUMP_SPEED
		return true
	return false
	
func get_input_direction():
	var input_direction = Vector2()
	input_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	return input_direction