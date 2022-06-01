extends AnimatedSprite

signal particle_finished

func _ready():
	frame = 0

func _on_animation_finished():
	emit_signal("particle_finished")
	queue_free()
