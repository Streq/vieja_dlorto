extends Node2D
class_name Skill

export var skill_name: String

func enter(witch):
	pass
func exit(witch):
	pass	
func can_use(witch) -> bool:
	return false
func use(witch):
	pass
func is_continuous() -> bool:
	return true
