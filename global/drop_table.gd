extends Node

var table = [
	{"name": "sword", "drop":preload("res://skills/sword/sword_pickup.tscn"), "rate":1.0},
	{"name": "wand", "drop":preload("res://skills/wand/wand_pickup.tscn"), "rate":1.0},
	{"name": "shotgun", "drop":preload("res://skills/shotgun/shotgun_pickup.tscn"), "rate":1.0},
	{"name": "teleport", "drop":preload("res://skills/teleport/teleport_pickup.tscn"), "rate":1.0},
	{"name": "health", "drop":preload("res://pickup/health/health.tscn"), "rate":1.0},
]

func get_table_rate(exceptions:Array):
	var ret = 0.0
	for item in table:
		if exceptions.find(item.name) == -1:
			ret += item.rate
	return ret

func roll(exceptions:Array):
	var roll = rand_range(0, get_table_rate(exceptions))
	
	for item in table:
		if exceptions.find(item.name) == -1:
			if roll <= item.rate:
				return item.drop
			roll -= item.rate
