extends Node2D

export var main_spell_cost := 1.0
export var continuous: bool = true

var casting = false
var odd_swing = true
var caster = null

func set_team(team):
	$hitbox.team = team


func cast(caster):
	if !casting:
		casting = true
		caster.mana -= main_spell_cost
		caster.shooting = true
		$hitbox.activate()
		if odd_swing:
			caster.animation.play("swing0")
		else:
			caster.animation.play("swing1")
		odd_swing = !odd_swing
		yield(caster.animation,"animation_finished")
		$hitbox.deactivate()
		casting = false
	
