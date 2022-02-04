extends Node2D

export var skill: PackedScene
var instance = null
func _ready():
	instance = skill.instance()
	$Sprite.texture = instance.texture
	
func _on_Area2D_body_entered(body):
	body.pickup_entered(self)
	$Label.visible = true


func _on_Area2D_body_exited(body):
	body.pickup_exited(self)
	$Label.visible = false

func consume():
	queue_free()
