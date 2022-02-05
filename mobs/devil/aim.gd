extends Node2D


func aim(global_pos):
	global_rotation = (global_pos-global_position).angle()

func _physics_process(delta):
	aim(owner.target.global_position)

func shoot():
	$bow.cast(owner)
