extends Node2D

signal particle_finished

onready var NumberLabel: Label = $label_holder/Label
var bounty_value: int = 0


func _ready():
	NumberLabel.text = "+%s" % bounty_value
	

func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name: 
		"move": 
			emit_signal("particle_finished")
			queue_free()
