extends Node


func roll():
	var full_chance = 0
	for child in get_children():
		full_chance += child.chance
	
	var roll = rand_range(0.0, full_chance)
	
	for child in get_children():
		if roll <= child.chance:
			return child.mob
		roll -= child.chance
