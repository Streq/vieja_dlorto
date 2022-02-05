extends CPUParticles2D

var velocity := Vector2.ZERO

func _ready():
	emitting = true

func _physics_process(delta):
	position += velocity*delta
