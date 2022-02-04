extends Node2D
	
func _on_Area2D_body_entered(body):
	consume(body)

func consume(player):
	$effect.trigger(player)
	queue_free()
