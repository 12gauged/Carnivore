extends Node2D

signal particle_finished

export(String) var particle_id
export(Dictionary) var custom_values = {}

onready var Particle = resources.get_resource("particles", particle_id)
onready var ParticleGroup = toolbox.get_node_in_group("particles")


func emit_particle():
	var NewParticle = Particle.instance()
	apply_custom_values(NewParticle, custom_values)
	ParticleGroup.add_child(NewParticle)
	NewParticle.global_position = self.global_position
	NewParticle.connect("particle_finished", self, "_on_particle_finished")
	
	
func apply_custom_values(TargetNode, values: Dictionary):
	if custom_values == {}: return
	for key in values.keys():
		#print("setting %s to %s" % [key, values[key]])
		TargetNode.set(key, values[key])
		
		
func add_custom_value(key, value):
	if key in custom_values.keys(): assert(true, "particle emitter.gd: custom value already exists.")
	custom_values[key] = value


func _on_particle_finished():
	emit_signal("particle_finished")
