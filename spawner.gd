extends Node2D

export var monster : PackedScene 


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	$Path2D/PathFollow2D.unit_offset = rand_range(0.0, 1.0)
	var mob = monster.instance()
	mob.position = $Path2D/PathFollow2D.global_position
	owner.add_child(mob)
	pass # Replace with function body.
