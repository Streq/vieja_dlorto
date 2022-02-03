extends Area2D

export var damage := 1.0
var team

func get_damage():
	return damage
	
func get_knockback():
	return owner.get_velocity()*0.05
