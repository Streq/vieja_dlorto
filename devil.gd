extends Node2D

signal dead()
signal drop_something(at)


export var speed := 500.0
var velocity := Vector2.ZERO
export var max_health := 10.0 
export (float) var health := max_health
export (float) var drop_rate := 0.2

var target = null
var team = 1
var dead = false

func target_player():
	var tree = get_tree()
	if tree:
		var players = tree.get_nodes_in_group("player")
		if players.size():
			target = players[0]

func _ready():
	target_player()
	$hurtbox.team = team
	$hitbox.team = team
	
func _physics_process(delta):
	velocity += to_local(target.global_position).normalized()*speed*delta
	velocity = lerp(velocity, Vector2.ZERO, delta)
	position += velocity*delta


func _on_hurtbox_area_entered(area):
	if area.team != team:
		velocity += area.get_knockback()
		health -= area.get_damage()
		if health <= 0.0 and !dead:
			die()
			
func die():
	dead = true
	emit_signal("dead")
	if(rand_range(0.0,1.0)) < drop_rate:
		drop()
	queue_free()
func drop():
	var drop = DropTable.roll().instance()
	get_parent().add_child(drop)
	drop.position = position
func _on_hitbox_area_entered(area):
	pass # Replace with function body.
