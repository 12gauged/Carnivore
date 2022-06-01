extends Node2D

signal particle_finished

export(String) var particle_id

onready var Particle = resources.get_resource("particles", particle_id)
onready var ParticleGroup = toolbox.get_node_in_group("particles")

func emit_particle():
	var NewParticle = Particle.instance()
	ParticleGroup.add_child(NewParticle)
	NewParticle.global_position = self.global_position
	NewParticle.connect("particle_finished", self, "_on_particle_finished")


func _on_particle_finished():
	emit_signal("particle_finished")
