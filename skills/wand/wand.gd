extends Node2D

signal cast(caster)

export var main_spell_cost := 1.0
export var continuous: bool = true

onready var cooldown_timer = $cooldown
var cooldown := false


func set_team(team):
	$hitbox.team = team

func cast(caster):
	if !cooldown:
		cooldown = true
		caster.swing.rotation_degrees = 0
		caster.mana -= main_spell_cost
		caster.shooting = true
		emit_signal("cast", caster)
		cooldown_timer.start()





func _on_cooldown_timeout():
	cooldown = false
