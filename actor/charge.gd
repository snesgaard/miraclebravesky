extends "res://actor/base.gd"

onready var root = $"../.."
onready var player = $"../../AnimationPlayer"
onready var sprite = $"../../Sprite"

var attack_ready = false

func animation_updates():
	player.play("twohanded_charge_idle2charge")
	yield(player, "animation_finished")
	player.play("twohanded_charge_charge")
	attack_ready = true

var animation_co = null


func enter(arg):
	animation_co = animation_updates()
	root.speed.x = 0
	attack_ready = false
	
func exit():
	animation_co = null

func update(dt):
	pass#if not Input.is_action_pressed("attack") and attack_ready:
	#	emit_signal("finished", "attack")
	#root.speed = root.update_motion(dt, root.speed)