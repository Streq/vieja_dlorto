extends Node2D

var speed := 2000.0

var inertia := Vector2.ZERO
var caster = null
var team

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
		queue_free()
