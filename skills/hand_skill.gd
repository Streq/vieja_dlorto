extends Skill

export var weapon: PackedScene
export var texture: Texture

var instance = null

func enter(witch):
	instance = weapon.instance()
	witch.hand.add_child(instance)
	
func exit(witch):
	witch.hand.remove_child(instance)
	
func can_use(witch):
	return instance.main_spell_cost < witch.mana
	
func use(witch):
	instance.cast(witch)

func is_continuous() -> bool:
	return instance.continuous
