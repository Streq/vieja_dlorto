extends Node2D

export var spell : PackedScene
export var main_spell_cost := 1.0
export var continuous: bool = true


func cast(caster):
	caster.mana -= main_spell_cost
	caster.shooting = true
	var new_spell = spell.instance()
	new_spell.set_as_toplevel(true)
	new_spell.position = global_position
	new_spell.rotation = global_rotation
	new_spell.inertia = caster.velocity
	new_spell.caster = caster
	new_spell.team = caster.team
	add_child(new_spell)
