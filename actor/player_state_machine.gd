extends "res://scripts/state_machine.gd"

onready var body = $".."
var face = 1

func _ready():
	states_map = {
		"idle": $idle,
		"move": $move,
		"charge": $charge,
		"attack": $attack,
		"evade": $evade
	}
	var hb = $"../hitboxes"
	hb.connect("body_shape_entered", self, "handle_collision")

func handle_collision(body_id, body, body_shape, area_shape):
	print("yes", body_id, body, body_shape, area_shape)
	if body.has_method("deal_damage"):
		body.call("deal_damage", face)

func direction(dir=null):
	if dir == null:
		return face
	if dir == face or abs(dir) != 1:
		return face
	body.scale.x = -1
	face = dir
	return face