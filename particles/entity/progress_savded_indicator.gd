extends Node2D

signal particle_finished


func _on_AnimationPlayer_animation_finished(_anim_name):
	emit_signal("particle_finished")
