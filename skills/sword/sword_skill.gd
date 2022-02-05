extends Skill

export var weapon: PackedScene
export var texture: Texture

var instance = null

func enter(witch):
	instance = weapon.instance()
	instance.set_team(witch.team)
	witch.hand.add_child(instance)
	witch.swing.rotation_degrees = -90
	instance.caster = witch
func exit(witch):
	witch.hand.remove_child(instance)
	witch.swing.rotation_degrees = 0
	
func can_use(witch):
	return instance.main_spell_cost < witch.mana
	
func use(witch):
	instance.cast(witch)

func is_continuous() -> bool:
	return instance.continuous
