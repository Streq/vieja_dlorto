extends Node2D

export var main_spell_cost := 10.0
export var continuous: bool = false

func cast(caster):
	caster.mana -= main_spell_cost
	caster.shooting = true
	var canvas_pos = caster.get_global_transform_with_canvas().get_origin()
	var offset = get_viewport().get_mouse_position()-canvas_pos
	get_viewport().warp_mouse(caster.get_global_transform_with_canvas().get_origin())
	caster.global_position += offset
	var cam = caster.get_node("Camera2D")
	cam.position = -cam.position
	
