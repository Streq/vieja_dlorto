extends PickupEffect


export var health:=100.0

func trigger(player):
	player.health += health
