extends Node2D

export var spell : PackedScene

onready var anim = $AnimationPlayer

func set_team(team):
	$hitbox.team = team

func cast(caster):
	anim.play("shoot")
	var new_spell = spell.instance()
	new_spell.set_as_toplevel(true)
	new_spell.position = global_position
	new_spell.rotation = global_rotation
	new_spell.caster = caster
	new_spell.team = caster.team
	add_child(new_spell)
