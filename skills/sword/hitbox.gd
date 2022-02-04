extends Area2D

export var damage := 5.0
var team

func activate():
	call_deferred("activate_deferred")
func activate_deferred():
	monitoring=true
	monitorable=true
	visible=true

func deactivate():
	call_deferred("deactivate_deferred")
func deactivate_deferred():
	monitoring=false
	monitorable=false
	visible=false

func get_damage():
	return damage
	
func get_knockback(target = null):
	return Vector2(cos(global_rotation), sin(global_rotation))*2000.0
