extends HBoxContainer


func set_weapon_hud(idx, skill):
	get_child(idx).get_node("weapon/texture").texture = skill.texture
