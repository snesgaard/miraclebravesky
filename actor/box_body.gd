extends "res://actor/platform_body.gd"

onready var fsm = $state_machine

func deal_damage(dir):
	fsm._change_state("thrown", dir)