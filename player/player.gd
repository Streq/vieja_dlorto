extends KinematicBody2D

signal health_changed(new_val)
signal mana_changed(new_val)
signal skill_changed(idx, skill)
signal dead()

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
onready var hand = $pivot/arm/swing_node/hand
onready var swing = $pivot/arm/swing_node
onready var animation = $AnimationPlayer
onready var hurt_anim = $hurt_anim
onready var skills = [null, null]
onready var just_pressed = [false, false]

var pickups = []


var dir := Vector2.ZERO
var team = 0

func _ready():
	$pivot/hurtbox.team = team

func set_skill(idx, skill):
	if skills[idx]:
		skills[idx].exit(self)
	skills[idx] = skill
	skill.enter(self)
	emit_signal("skill_changed", idx, skill)

func _physics_process(delta):
	dir = get_input_dir()
	velocity.y += gravity*delta
	velocity += dir*speed*delta
	velocity = lerp(velocity, Vector2.ZERO, lerp_friction*delta)
	
	velocity = move_and_slide(velocity, Vector2.UP)
	if skills[0] and (skills[0].is_continuous() or just_pressed[0]) and Input.is_mouse_button_pressed(BUTTON_LEFT) and skills[0].can_use(self):
			skills[0].use(self)
	if skills[1] and (skills[1].is_continuous() or just_pressed[1]) and Input.is_mouse_button_pressed(BUTTON_RIGHT) and skills[1].can_use(self):
			skills[1].use(self)
	
	just_pressed[0]=false
	just_pressed[1]=false
	
	
	if dir!=Vector2.ZERO:
		
		$pivot.rotation = lerp_angle($pivot.rotation, dir.angle(), 6.0*delta)
		if !animation.is_playing():
			$pivot.scale.y = sign(dir.x) if dir.x else $pivot.scale.y
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

func _input(event):
	if event.is_action_pressed("skill0"):
		just_pressed[0] = true
	if event.is_action_pressed("skill1"):
		just_pressed[1] = true
	
	if event.is_action_pressed("grab0"):
		if pickups.size():
			set_skill(0, pickups[0].instance)
			pickups[0].consume()
	if event.is_action_pressed("grab1"):
		if pickups.size():
			set_skill(1, pickups[0].instance)
			pickups[0].consume()


var invulnerable = false
func _on_hurtbox_area_entered(area):
	if area.team != team:
		velocity += area.get_knockback(self)
		if !invulnerable:
			invulnerable = true
			hurt_anim.play("hurt")
			self.health -= area.get_damage()
			yield(get_tree().create_timer(0.5),"timeout")
			invulnerable = false
func set_mana(val):
	mana = min(val, max_mana)
	emit_signal("mana_changed", mana)

func set_health(val):
	health = min(val, max_health)
	emit_signal("health_changed", health)
	if health <= 0.0:
		emit_signal("dead")
	
func get_input_dir():
	return Vector2\
		( float(Input.is_action_pressed("ui_right"))-float(Input.is_action_pressed("ui_left"))\
		, float(Input.is_action_pressed("ui_down"))-float(Input.is_action_pressed("ui_up"))\
		).normalized()

func pickup_entered(pickup):
	for i in range(0, 2):
		if !skills[i]:
			set_skill(i, pickup.instance)
			pickup.consume()
			return
	pickups.append(pickup)

func pickup_exited(pickup):
	var idx = pickups.find(pickup)
	if idx != -1:
		pickups.remove(idx)
	
func get_held_items():
	return [skills[0].skill_name if skills[0] else null, skills[1].skill_name if skills[1] else null]
