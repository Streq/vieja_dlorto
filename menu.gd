extends Node2D


signal begin(difficulty)
signal done()

func _on_easy_dead():
	emit_signal("begin", "easy")

func _on_medium_dead():
	emit_signal("begin", "medium")

func _on_hard_dead():
	emit_signal("begin", "hard")


func _on_menu_begin(difficulty):
	emit_signal("done")
