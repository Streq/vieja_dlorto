extends Node2D

export var speed := 2000.0

var inertia := Vector2.ZERO
var caster = null
var team

onready var audio= $AudioStreamPlayer2D

func _ready():
	$Timer.connect("timeout",self,"queue_free")
	$Timer.start()
	$hitbox.team = team

func _physics_process(delta):
	move_local_x(speed*delta)
	position += inertia*delta

func _on_body_entered(body):
	if body != caster:
		queue_free()

func get_velocity():
	return inertia+Vector2(cos(rotation),sin(rotation))*speed


func _on_hitbox_area_entered(area):
	if area.team != team:
		
		remove_child(audio)
		get_parent().add_child(audio)
		audio.global_position = global_position
		audio.connect("finished", audio, "queue_free")
		audio.play()
		queue_free()
		
