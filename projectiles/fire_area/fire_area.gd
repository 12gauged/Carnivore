extends Node2D

onready var ParticleEmitter: CPUParticles2D = $CPUParticles2D
var lifetime = 1.0

func delete():
	ParticleEmitter.emitting = false
	yield(get_tree().create_timer(lifetime), "timeout")
	queue_free()
