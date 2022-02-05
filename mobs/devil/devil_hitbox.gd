extends Area2D

var team
export var knockback := 1000.0
export var damage := 20.0

func get_knockback(target):
	return to_local(target.global_position).normalized()*knockback

func get_damage():
	return damage
