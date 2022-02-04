extends Node2D

signal mob_killed()
signal time_til_next(val)
export var monster : PackedScene 


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_kill():
	emit_signal("mob_killed")

func _on_Timer_timeout():
	$Path2D/PathFollow2D.unit_offset = rand_range(0.0, 1.0)
	var mob = monster.instance()
	mob.position = $Path2D/PathFollow2D.global_position
	mob.connect("dead", self, "_on_kill")
	owner.add_child(mob)
	$Timer.wait_time = $Timer.wait_time*0.99
	emit_signal("time_til_next", $Timer.wait_time)
	pass # Replace with function body.
