extends "res://actor/base.gd"

onready var root = $"../.."
onready var player = $"../../AnimationPlayer"
onready var sprite = $"../../Sprite"
onready var idle = $"idle"

var interrupt = false

func animation_proc(context):
	interrupt = false
	player.play("twohanded_charge_swing")
	yield(player, "animation_finished")
	player.play("twohanded_charge_post_swing")
	yield(get_tree().create_timer(0.15), "timeout")
	interrupt = true
	yield(get_tree().create_timer(0.25), "timeout")
	player.play("twohanded_charge_swing2idle")
	yield(player, "animation_finished")
	if context["alive"]:
		emit_signal("finished", "idle")
	
var animation_co = null
var context = null

func make_context():
	return {"alive": true}

func enter(arg):
	context = make_context()
	animation_co = animation_proc(context)

func exit():
	context["alive"] = false
	animation_co = null

func update(dt):
	if not interrupt:
		return
	if update_jump(root, 0):
		emit_signal("finished", "idle")
	if Input.is_action_just_pressed("evade"):
		emit_signal("finished", "evade")