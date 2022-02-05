extends Area2D

export var damage := 1.0
export var knockback := 0.05
var team

func get_damage():
	return damage
	
func get_knockback(target = null):
	return owner.get_velocity()*knockback
