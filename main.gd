extends Node2D

signal highscore(highscore)

var kills := 0


func _ready():
	emit_signal("highscore", Global.highscore)
	
func _on_player_dead():
	if kills > Global.highscore:
		Global.highscore = kills
		Global.save_game()
	get_tree().reload_current_scene()


func _on_devil_dead():
	kills += 1
