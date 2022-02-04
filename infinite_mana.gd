extends Node

export var power := 0.75

func _physics_process(delta):
	get_parent().mana += power

func _timeout():
	queue_free()
