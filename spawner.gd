extends Node2D

signal mob_killed()
signal time_til_next(val)


func _on_kill():
	emit_signal("mob_killed")

func _on_Timer_timeout():
	$Path2D/PathFollow2D.unit_offset = rand_range(0.0, 1.0)
	var mob = $mobs.roll().instance()
	mob.position = $Path2D/PathFollow2D.global_position
	mob.connect("dead", self, "_on_kill")
	owner.add_child(mob)
	$Timer.wait_time = $Timer.wait_time*0.99
	emit_signal("time_til_next", $Timer.wait_time)
	pass # Replace with function body.


