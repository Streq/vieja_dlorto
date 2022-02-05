extends Label

export var counter := 0.0 setget set_counter
export var thing := "kills"
export var float_padding := 0

func set_counter(val):
	counter = val
	text = "%s: %.{padding}f".format([float_padding],"{padding}") % [thing, counter]


func increment():
	set_counter(counter+1)

func _ready():
	set_counter(0)
