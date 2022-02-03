extends Node2D

export var spell : PackedScene
var caster = null
export var main_spell_cost := 1.0
	
func _physics_process(delta):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		if main_spell_cost < caster.mana:
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
		
func set_caster_to_owner():
	caster = owner
