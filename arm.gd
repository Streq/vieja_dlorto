extends Node2D


func _physics_process(delta):
	var parent = get_parent()
	var canvas_pos = get_global_transform_with_canvas().get_origin()
	
	#get distance from arm to scope
	var scope_dist = get_viewport().get_mouse_position()-canvas_pos
	
	#make distance relative to rotation and scale of pivot
	var scope_pivoted_dist = parent.get_transform().xform_inv(scope_dist)
	
	#rotate towards the scope
	var angle = (scope_pivoted_dist).angle()
	rotation = angle
	
