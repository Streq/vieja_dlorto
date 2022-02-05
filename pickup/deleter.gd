extends Timer


func timeout():
	owner.queue_free()
