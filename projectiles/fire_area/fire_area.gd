extends Node2D

onready var ParticleEmitter: CPUParticles2D = $CPUParticles2D

func delete():
	ParticleEmitter.emitting = false
	yield(get_tree().create_timer(1.0), "timeout")
	queue_free()
