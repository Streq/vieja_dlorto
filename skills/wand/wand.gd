extends Node2D

signal cast(caster)

export var main_spell_cost := 1.0
export var continuous: bool = true

onready var cooldown_timer = $cooldown
var cooldown := false

var shot_this_frame = false


func _physics_process(delta):
	if shot_this_frame:
		if !$AudioStreamPlayer2D.playing:
			pass
#			$AudioStreamPlayer2D.play()
	else:
		$AudioStreamPlayer2D.stop()
	shot_this_frame = false
func set_team(team):
	$hitbox.team = team

func cast(caster):
	if !cooldown:
		shot_this_frame = true
		cooldown = true
		caster.swing.rotation_degrees = 0
		caster.mana -= main_spell_cost
		caster.shooting = true
		emit_signal("cast", caster)
		cooldown_timer.start()
			




func _on_cooldown_timeout():
	cooldown = false
