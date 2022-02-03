extends KinematicBody2D

signal health_changed(new_val)
signal mana_changed(new_val)

export var speed := 2000.0
export var velocity := Vector2.ZERO
export var gravity := 400.0
export var lerp_friction = 0.2
export var max_health := 100.0
export var max_mana := 100.0
export (float) var health := max_health setget set_health
export (float) var mana := max_mana setget set_mana
export (float) var mana_regen = 0.5
export (float) var health_regen = 0.1
var shooting = false


var dir := Vector2.ZERO
var team = 0

func _ready():
	$pivot/hurtbox.team = team

func _physics_process(delta):
	dir.x = float(Input.is_action_pressed("ui_right"))-float(Input.is_action_pressed("ui_left"))
	dir.y = float(Input.is_action_pressed("ui_down"))-float(Input.is_action_pressed("ui_up"))
	dir = dir.normalized()
	velocity.y += gravity*delta
	velocity += dir*speed*delta
	velocity = lerp(velocity, Vector2.ZERO, lerp_friction*delta)
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if dir!=Vector2.ZERO:
		
		$pivot.rotation = lerp_angle($pivot.rotation, dir.angle(), 6.0*delta)
		$pivot.scale.y = sign(dir.x) if dir.x else $pivot.scale.x
#		$pivot.transform = Transform2D.IDENTITY\
#				.rotated(lerp($pivot.rotation*sign(dir.x), Vector2(abs(dir.x), dir.y).angle(), 6.0*delta))\
#				.scaled(Vector2(sign(dir.x) if dir.x!=0.0 else $pivot.transform.get_scale().y, 1))
##		var scale_to = Vector2(sign(dir.x) if dir.x!=0.0 else $pivot.transform.get_scale().y, 1)
#
#		$pivot.transform = $pivot.transform.interpolate_with\
#			( Transform2D.IDENTITY\
#				.rotated(Vector2(abs(dir.x), dir.y).angle())\
#			, 6.0*delta)
#		$pivot.transform = $pivot.transform.scaled(scale_to)
		
#	$Camera2D.position = lerp($Camera2D.position, OS.window_size*dir*0.5, delta)
	var vp = get_viewport()
	$Camera2D.position = lerp($Camera2D.position, (vp.get_mouse_position()-vp.size*0.5)/global_scale, 6*delta)
#	$Camera2D.position = lerp($Camera2D.position, (get_viewport().get_mouse_position()-get_viewport().size*0.5).sign()*get_viewport().size*0.5, 1*delta)
	if !shooting:
		self.mana += max(0.1,mana/max_mana)*1.0
	shooting = false
	self.health += health_regen


func _on_hurtbox_area_entered(area):
	if area.team != team:
		self.health -= area.get_damage()
		velocity += area.get_knockback(self)
		if health <= 0.0:
			get_tree().reload_current_scene()

func set_mana(val):
	mana = min(val, max_mana)
	emit_signal("mana_changed", mana)

func set_health(val):
	health = min(val, max_health)
	emit_signal("health_changed", health)
	
