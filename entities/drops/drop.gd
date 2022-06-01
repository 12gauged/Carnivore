extends Area2D

signal interacted

const TAGS: Array = ["COMP_EXECUTER", "DROP"]
onready var Particle = resources.get_resource("particles", "pickup")
onready var ParticleGroup = toolbox.get_node_in_group("particles")
	
func _on_interacted():
	emit_signal("interacted") 
	spawn_particle()
	queue_free()
	
func spawn_particle():
	var NewParticle = Particle.instance()
	ParticleGroup.add_child(NewParticle)
	NewParticle.global_position = self.global_position

func get_texture(): return $texture

func _on_lifetime_timer_timeout():
	$drop_animation.play("delete")
