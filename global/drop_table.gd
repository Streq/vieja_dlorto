extends Node

var table = [
	{"drop":preload("res://skills/sword/sword_pickup.tscn"), "rate":1.0},
	{"drop":preload("res://skills/wand/wand_pickup.tscn"), "rate":1.0},
	{"drop":preload("res://skills/teleport/teleport_pickup.tscn"), "rate":1.0},
]

func get_table_rate():
	var ret = 0.0
	for item in table:
		ret += item.rate
	return ret

func roll():
	var roll = rand_range(0, get_table_rate())
	
	for item in table:
		if roll < item.rate:
			return item.drop
		roll -= item.rate
